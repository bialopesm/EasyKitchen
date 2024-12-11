class AddRecipeRefToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_reference :ingredients, :recipe, null: false, foreign_key: true
  end
end
