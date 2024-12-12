class Ingredient < ApplicationRecord

  validates :name, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }, if: :quantity_present?

  scope :ordered, -> { order(id: :desc) }

  private

  def quantity_present?
    quantity.present?
  end

end
