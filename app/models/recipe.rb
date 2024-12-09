class Recipe < ApplicationRecord
  belongs_to :user, through: :bookmarks
  has_many :ingredients,
  has_many :comments
end
