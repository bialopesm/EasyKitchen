class AddUnitToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :unit, :string
  end
end
