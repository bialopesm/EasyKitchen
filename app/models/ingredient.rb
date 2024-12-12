class Ingredient < ApplicationRecord

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }


end
