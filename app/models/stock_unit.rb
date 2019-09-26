# frozen_string_literal: true

class StockUnit < ApplicationRecord
  validates :name, uniqueness: true

  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients
  has_many :stock_movements
end
