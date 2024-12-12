class Ingredient < ApplicationRecord

  scope :ordered, -> { order(id: :desc) }

  belongs_to :user
  validates :name, presence: true
  validates :quantity, presence: true

  validates :quantity, numericality: { greater_than: 0 }, if: :quantity_present?

  private

  def quantity_present?
    quantity.present?
  end

end
