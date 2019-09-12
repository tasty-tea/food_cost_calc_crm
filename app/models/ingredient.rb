# frozen_string_literal: true

class Ingredient < ApplicationRecord
  validates_uniqueness_of :stock_unit_id, scope: :product_id

  belongs_to :product
  belongs_to :stock_unit
end
