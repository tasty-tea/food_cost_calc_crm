# frozen_string_literal: true

class StockUnit < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients
end
