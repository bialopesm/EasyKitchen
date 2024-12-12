class RemoveRecipeFromIngredients < ActiveRecord::Migration[7.1]
  def change
    remove_reference :ingredients, :recipe, null: false, foreign_key: true
  end
end
