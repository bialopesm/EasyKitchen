class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :comments
  has_many :bookmarks
end
