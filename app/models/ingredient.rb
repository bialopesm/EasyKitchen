class Ingredient < ApplicationRecord

  scope :ordered, -> { order(id: :desc) }



  validates :name, presence: true
  validates :quantity, presence: true

end
