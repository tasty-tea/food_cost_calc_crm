# frozen_string_literal: true

class Ingredient < ApplicationRecord
  validates :stock_unit_id, uniqueness: { scope: :product_id }, presence: true
  validates :product_id, :amount, presence: true

  belongs_to :product
  belongs_to :stock_unit
end
