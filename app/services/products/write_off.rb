# frozen_string_literal: true

module Products
  class WriteOff < BaseServiceObject
    option :product_id
    option :amount
    option :brake, default: -> { false }

    def call
      result_object = []
      StockMovement.transaction do
        product.ingredients.each do |ingredient|
          stu = ingredient.stock_unit
          imul = (ingredient.amount.to_i * amount.to_i)
          iamount = (brake == 0) ? -imul : imul
          result_object << StockMovements::Create.call(stu.id,
                                                       amount: iamount,
                                                       cost: effective_cost(ingredient),
                                                       brake: brake)
        end
      end
      Result.new(object: result_object, success: true)
    end

    private

    def product
      @product ||= Product.find(product_id)
    end

    def effective_cost(ingredient)
      ingredient.stock_unit.cost
    end
  end
end
