module Products
  class WriteOff < BaseServiceObject
    param :stock_unit_id

    option :amount
    option :cost
    option :measure_units
    option :brake, default: -> { false }

    def call
      validate
      return self unless valid?

      selling.save!
      # some logic after saving Post
      self.result = selling
      self
    end

    private

    def validate
      errors.add(:base, 'please specify amount') unless amount
      errors.merge_with_models(selling) unless selling.valid?
    end

    def selling
      @selling ||= Sellings.new(stock_unit_id: stock_unit_id, amount: amount, cost: cost, measure_units: measure_units, brake: brake)
    end
  end
end
