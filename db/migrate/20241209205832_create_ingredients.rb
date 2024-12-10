class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.string :ingredient_image
      t.integer :quantity


      t.timestamps
    end
  end
end
