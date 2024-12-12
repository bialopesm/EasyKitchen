class User < ApplicationRecord
  has_many :bookmarks
  has_many :recipes, through: :bookmarks
  has_many :bookmarks
  has_many :ingredients
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
