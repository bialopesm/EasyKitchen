class Recipe < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
  has_many :users, through: :bookmarks
  has_many :ingredients
  has_many :comments
end
