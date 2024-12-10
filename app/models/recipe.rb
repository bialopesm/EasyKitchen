class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :comments
  has_many :bookmarks
end
