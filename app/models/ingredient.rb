class Ingredient < ApplicationRecord

  scope :ordered, -> { order(id: :desc) }
  belongs_to :recipe
  validates :name, presence: true
  validates :quantity, presence: true

end
