# frozen_string_literal: true

module Ingredients
  class MeasureConversion < BaseServiceObject
    option :stock_unit_id
    option :amount
    option :measure_units

    MEASURE_UNTIS_LIST = {kg:     {g: 1000, kg: 1},
                          g:     {kg: 0.001, g: 1},
                          l:      {ml: 1000, l: 1},
                          ml:     {l: 0.001, ml: 1},
                          pieces: {pieces: 1}}

    def call
      return failure_result if !valid?
      return failure_result if !stock_unit
      target_meagure_units = stock_unit.measure_units

      conversion_coeffitient = MEASURE_UNTIS_LIST[measure_units.to_sym].try(:[], target_meagure_units.to_sym)
      return failure_result if !conversion_coeffitient

      converted_object = StockUnit.new(amount: amount * conversion_coeffitient,
                                         measure_units: target_meagure_units)
      Result.new(object: converted_object, success: true)
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def failure_result
      Result.new(object: StockUnit.new(amount: nil, measure_units: nil), success: false)
    end

    def stock_unit
      @stock_unit = StockUnit.find_by(id: stock_unit_id)
    end

    def validate!
      raise ArgumentError if stock_unit_id.nil?
      raise ArgumentError if amount.nil?
      raise ArgumentError if measure_units.nil?
    end
  end
end
