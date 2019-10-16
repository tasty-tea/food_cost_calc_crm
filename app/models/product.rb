# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, uniqueness: true, presence: true 

  has_many :ingredients, dependent: :destroy
  has_many :stock_units, through: :ingredients
  has_many :sellings, dependent: :destroy

  scope :ordered, -> { order(:id) }

  def list_ingredients
    ingredients.map { |i| { id: i.id, name: i.stock_unit.name, amount: i.amount, stock_unit_id: i.stock_unit.id } }
  end

  def write_off(pieces)
    StockUnit.transaction do
      ingredients.each do |ingredient|
        stu = ingredient.stock_unit
        stu.amount -= ingredient.amount * pieces
        stu.save!
      end
    end
  end
end
