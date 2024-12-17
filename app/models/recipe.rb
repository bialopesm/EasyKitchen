class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :comments, dependent: :destroy
  has_many :bookmarks
end
