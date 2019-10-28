# frozen_string_literal: true

module StockUnits
  class CalcAmount < BaseServiceObject
    param :stock_unit_id

    # TODO: move to value_objects
    def call
      result_object = stock_unit.stock_movements.sum(:amount)
      Result.new(object: result_object, success: true)
    end

    private

    def stock_unit
      @stock_unit ||= StockUnit.find(stock_unit_id)
    end
  end
end
