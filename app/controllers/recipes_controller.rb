class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new # Needed to instantiate the form_with
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save
    # No need for app/views/recipes/create.html.erb
    redirect_to recipe_path(@recipe)
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

  def recipe_params
    params.require(:recipe).permit()
  end
end
