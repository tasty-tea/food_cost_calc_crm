# frozen_string_literal: true

module StockMovements
  class Create < BaseServiceObject
    param :stock_unit
    option :selling
    option :amount
    option :cost
    option :measure_units, default: -> { stock_unit&.measure_units }
    option :brake, default: -> { false }

    def call
      return failure_result unless valid?

      stock_movement.save!
      Result.new(object: stock_movement, success: true)
    end

    private

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    # TODO: automaticly calculate to correct measure
    def stock_movement
      measure_units = stock_unit&.measure_units
      @stock_movement ||= StockMovement.new(stock_unit: stock_unit,
                                            selling: selling,
                                            amount: amount,
                                            cost: cost,
                                            measure_units: measure_units,
                                            brake: brake)
    end

    def validate!
      raise StandardError if [stock_unit, selling, amount].any?(&:nil?)
    end

    def failure_result
      Result.new(object: StockMovement.new, success: false)
    end
  end
end
