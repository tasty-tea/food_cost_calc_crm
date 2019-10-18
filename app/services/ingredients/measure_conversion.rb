# frozen_string_literal: true

module Ingredients
  class MeasureConversion < BaseServiceObject
    option :source_measure_units
    option :target_measure_units
    option :amount
    option :config, default: -> { Rails.configuration.application['measure_units_list'] }

    def call
      return failure_result unless valid?

      coeffitient = config.dig(source_measure_units, target_measure_units)
      return failure_result unless coeffitient

      converted_object = StockUnit.new(amount: amount * coeffitient,
                                       measure_units: target_measure_units)
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
      Result.new(object: StockUnit.new, success: false)
    end

    def validate!
      raise ArgumentError if [source_measure_units, target_measure_units, amount].any?(&:nil?)
    end
  end
end
