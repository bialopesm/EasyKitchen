class ChangePreTimeToStringInRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column(:recipes, :prep_time, :string)
  end
end
