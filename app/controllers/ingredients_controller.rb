class IngredientsController < ApplicationController

  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    @ingredients = Ingredient.ordered
    @ingredient = Ingredient.new
  end

  def new
    @ingredient = Ingredient.new
    # @ingredients = Ingredient.all
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      respond_to do |format|
        format.html { redirect_to ingredients_path, notice: "ingredient was successfully created." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:ingredients, partial: "ingredients/ingredient",
            locals: { ingredient: @ingredient })
        end
        format.html { redirect_to ingredient_path(@ingredient) }
      end
    else
      # @ingredients = Ingredient.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredients_path, notice: "ingredient was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to ingredients_path, notice: "ingredient was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity)
  end
end
