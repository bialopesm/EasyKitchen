class Recipe < ApplicationRecord
  has_many :ingredients, inverse_of: :recipe
  has_many :comments
  has_many :bookmarks
  accepts_nested_attributes_for :ingredients
end
