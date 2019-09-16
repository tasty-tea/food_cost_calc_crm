# frozen_string_literal: true

class StockUnit < ApplicationRecord
  validates_uniqueness_of :name
  
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients
end
