# frozen_string_literal: true

module StockMovements
  class Create < BaseServiceObject
    param :stock_unit_id
    option :selling_id
    option :amount
    option :cost
    option :measure_units, default: -> { stock_unit.measure_units }
    option :brake, default: -> { false }

    def call
      validate
      return self unless valid?

      stock_movement.save!
      Result.new(object: stock_movement, success: true)
    end

    private

    def validate
      errors.add(:base, 'stock unit does not exist') unless @stock_unit
      errors.add(:base, 'please specify amount') unless amount
      errors.merge_with_models(stock_movement) unless stock_movement.valid?
    end

    def stock_unit
      @stock_unit ||= StockUnit.find(stock_unit_id)
    end

    # TODO: automaticly calculate to correct measure
    def stock_movement
      measure_units = stock_unit.measure_units
      @stock_movement ||= StockMovement.new(stock_unit_id: stock_unit_id,
                                            selling_id: selling_id,
                                            amount: amount,
                                            cost: cost,
                                            measure_units: measure_units,
                                            brake: brake)
    end
  end
end
