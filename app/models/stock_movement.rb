# frozen_string_literal: true

class StockMovement < ApplicationRecord
  belongs_to :stock_unit
  belongs_to :selling, optional: true
end
