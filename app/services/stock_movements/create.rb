module StockMovements
  class Create < BaseServiceObject
    param :stock_unit_id

    option :amount
    option :cost
    option :measure_units
    option :brake, default: -> { false }

    def call
      validate
      return self unless valid?

      stock_movement.save!
      # some logic after saving Post
      # self.result = stock_movement
      # self
      Result.new(object: stock_movement, success: true)
    end

    private

    def validate
      errors.add(:base, 'please specify user') unless amount
      errors.merge_with_models(stock_movement) unless stock_movement.valid?
    end

    def stock_movement
      @stock_movement ||= StockMovement.new(stock_unit_id: stock_unit_id, amount: amount, cost: cost, measure_units: measure_units, brake: brake)
    end
  end
end
