# frozen_string_literal: true

module Ingredients
  class WriteOff < BaseServiceObject
    option :product
    option :selling
    option :amount
    option :brake, default: -> { false }

    def call
      create_stock_movement
      Result.new(object: nil, success: true)
    end

    private

    def create_stock_movement
      product.ingredients.preload(:stock_unit).each do |ingredient|
        result = StockMovements::Create.call(ingredient.stock_unit,
                                             selling: selling,
                                             amount: total_amount(ingredient),
                                             cost: effective_cost(ingredient),
                                             brake: brake)

        raise ActiveRecord::Rollback unless result.success?
      end
    end

    def effective_cost(ingredient)
      ingredient.stock_unit.cost
    end

    def total_amount(ingredient)
      -1 * (ingredient.amount.to_i * amount.to_i)
    end
  end
end
