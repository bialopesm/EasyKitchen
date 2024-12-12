class Ingredient < ApplicationRecord

  scope :ordered, -> { order(id: :desc) }
  belongs_to :user
  validates :name, presence: true
  validates :quantity, presence: true
end
