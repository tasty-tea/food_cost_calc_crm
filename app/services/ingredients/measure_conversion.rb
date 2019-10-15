# frozen_string_literal: true

module Ingredients
  class MeasureConversion < BaseServiceObject
    option :source_measure_units
    option :target_measure_units
    option :amount
    option :config, default: -> { Rails.configuration.application['measure_units_list'] }

    def call
      return failure_result unless valid?

      coeffitient = conversion_coeffitient(source_measure_units, target_measure_units)
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

    def conversion_coeffitient(source, target)
      config[source].try(:[], target)
    end

    def failure_result
      Result.new(object: StockUnit.new(amount: nil, measure_units: nil), success: false)
    end

    def validate!
      raise ArgumentError if source_measure_units.nil?
      raise ArgumentError if target_measure_units.nil?
      raise ArgumentError if amount.nil?
    end
  end
end
