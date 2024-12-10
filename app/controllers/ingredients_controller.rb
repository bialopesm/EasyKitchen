class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
    @ingredients = Ingredient.all
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to @ingredient, notice: "Ingredient was added"
    else
      # @ingredients = Ingredient.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      redirect_to @ingredient, notice: "Ingredient was updated"
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity)
  end

end
