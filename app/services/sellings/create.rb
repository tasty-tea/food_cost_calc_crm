# frozen_string_literal: true

module Sellings
  class Create < BaseServiceObject
    param :user

    option :product_id
    option :amount
    option :brake, default: -> { false }

    def call
      validate
      return Result.new(object: selling, success: false) unless valid?

      ActiveRecord::Base.transaction do
        selling.save!
        Ingredients::WriteOff.call(product: product,
                                   selling: selling,
                                   amount: amount,
                                   brake: brake)
      end

      Result.new(object: selling, success: true)
    end

    private

    def validate
      errors.add(:base, 'user does not exits') unless @user
      errors.add(:base, 'please specify amount') unless amount
      errors.merge_with_models(selling) unless selling.valid?
    end

    def selling
      @selling ||= Selling.new(product: product,
                               amount: amount,
                               brake: brake,
                               user: user)
    end

    def product
      @product ||= Product.find(product_id)
    end
  end
end
