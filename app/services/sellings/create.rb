# frozen_string_literal: true

module Sellings
  class Create < BaseServiceObject
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
      # self.result = selling
      # self
      Result.new(selling, true)
    end

    private

    def validate
      errors.add(:base, 'please specify amount') unless amount
      errors.merge_with_models(selling) unless selling.valid?
    end

    def selling
      @selling ||= Selling.new(product: product,
                               amount: amount,
                               brake: brake,
                               user: user)
    end
  end
end
