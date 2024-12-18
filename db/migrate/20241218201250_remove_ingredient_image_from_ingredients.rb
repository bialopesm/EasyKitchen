class RemoveIngredientImageFromIngredients < ActiveRecord::Migration[7.2]
  def change
    remove_column :ingredients, :ingredient_image, :string
  end
end
