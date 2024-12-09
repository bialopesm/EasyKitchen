class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.text :instructions
      t.integer :rating
      t.string :title
      t.time :prep_time
      t.integer :servings
      t.boolean :done

      t.timestamps
    end
  end
end
