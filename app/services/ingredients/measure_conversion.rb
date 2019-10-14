# frozen_string_literal: true

module Ingredients
  class WriteOff < BaseServiceObject
    option :product
    option :selling
    option :amount
    option :brake, default: -> { false }

    def call
      stock_movements_created = []
      StockMovement.transaction do
        product.ingredients.each do |ingredient|
          stock_unit = ingredient.stock_unit
          total_amount = -1 * (ingredient.amount.to_i * amount.to_i)
          stock_movements_created << StockMovements::Create.call(stock_unit.id,
                                                                 selling_id: selling.id,
                                                                 amount: total_amount,
                                                                 cost: effective_cost(ingredient),
                                                                 brake: brake)
        end
      end
      Result.new(object: stock_movements_created, success: true)
    end

    private

    def effective_cost(ingredient)
      ingredient.stock_unit.cost
    end
  end
end
