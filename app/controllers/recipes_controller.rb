class RecipesController < ApplicationController

  def index
    ingredients_formated = current_user.ingredients.map { |ingredient| "#{ingredient.name} #{ingredient.quantity} #{ingredient.unit}/"}
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{
        role: "user",
        content: "Create 5 recipes using the following ingredients:

        #{ingredients_formated.join}

          The recipe should use this format bellow to display the 5 recipes:
          - Recipe title:
          - Ingredients list: (exactly as given all the ingredients)
          - Preparation time:
          - Servings:
          - Step-by-step: (instructions with details for each step)

          The message should return with the recipes separeted by $ Recipe title Ingredients list Preparation time Servings Step-by-step
          "
      }]
    })

    # Rails.logger.info "ChatGPT Response: #{chatgpt_response.inspect}"
    response_content = chatgpt_response["choices"][0]["message"]["content"]
    # Rails.logger.info "Response Content: #{response_content}"

    if session[:recipes].present?
      @recipes_from_gpt = session[:recipes]
    else
      @recipes_from_gpt = extract_recipes(response_content)
      session[:recipes] = @recipes_from_gpt
    end


    # @recipe.title = @recipe_from_gpt["Recipe title"]
    # @recipe.prep_time = @recipe_from_gpt["Preparation time"]
    # @recipe.servings = @recipe_from_gpt["Servings"]
    # @recipe.instructions = @recipe_from_gpt["Step-by-step"]

    Rails.logger.info "Structured Recipe: #{@recipes_from_gpt.inspect}"
  end


  def new
    @recipe = Recipe.new
  end

  def show
    # @recipe = Recipe.find(params[:id])
  end


  def create

    params.require(:recipe_data).permit("Recipe title", "Preparation time", "Servings", "Step-by-step")
    @recipe = Recipe.new()
    @recipe.title = params[:recipe_data]["Recipe title"]
    @recipe.prep_time = params[:recipe_data]["Preparation time"]
    @recipe.servings = params[:recipe_data]["Servings"]
    @recipe.instructions = params[:recipe_data]["Step-by-step"]
    @recipe.done = true
    @recipe.save
    @bookmark = Bookmark.new(user: current_user, recipe: @recipe)
    @bookmark.save
    # No need for app/views/recipes/create.html.erb
    redirect_to new_recipe_comment_path(@recipe)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    # No need for app/views/recipes/update.html.erb
    redirect_to recipe_path(@recipe)
  end

  private

  def extract_recipes(content)
    raw_recipes = content.split("$").map(&:strip)
    raw_recipes[1..].map do |raw_recipe|
      {
        "Recipe title" => extract_value(raw_recipe, "Recipe title:"),
        "Ingredients list" => extract_ingredients(raw_recipe, "Ingredients list:"),
        "Preparation time" => extract_value(raw_recipe, "Preparation time:"),
        "Servings" => extract_value(raw_recipe, "Servings:"),
        "Step-by-step" => extract_steps(raw_recipe, "Step-by-step:")
      }
    end
  end

  def extract_value(content, key)
    match = content.match(/#{key}\s*(.*?)(?=\n\s*-|\z)/)
    match ? match[1].strip : nil
  end

  def extract_ingredients(content, key)
    match = content.match(/#{key}\s*(.*?)(?=\n\s*-|\z)/)
    if match
      ingredients = match[1].strip
      ingredients.split("\n").map { |ingredient| ingredient.gsub(/^- /, '').strip }.join(", ")
    else
      nil
    end
  end

  def extract_steps(content, key)
    match = content.match(/#{key}\s*(.*?)(?=\z)/m)
    match ? match[1].strip : nil
  end

  def recipe_params
    params.require(:recipe).permit(:title, :rating, :instructions, :prep_time, :done, :servings)
  end

end
