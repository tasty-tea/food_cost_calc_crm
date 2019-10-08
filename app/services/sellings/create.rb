# frozen_string_literal: true

module Sellings
  class Create < BaseServiceObject
    param :user

    option :product_id
    option :amount
    option :brake, default: -> { false }
    #option :user_id

    def call
      validate
      return Result.new(object: self, success: false) unless valid?

      ActiveRecord::Base.transaction do
        Products::WriteOff.call(product_id: product_id,
                                amount: amount,
                                brake: brake)
        selling.save!
      end

      Result.new(object: selling, success: true)
    end

    private

    def validate
      errors.add(:base, 'please specify product') unless user
      errors.add(:base, 'please specify amount') unless amount
      errors.merge_with_models(selling) unless selling.valid?
    end

    def selling
      @selling ||= Selling.new(product: product,
                               amount: amount,
                               brake: brake,
                               user: user)
    end

    def user
      user_id = nil
      @user ||= user_id ? User.find(user_id) : user
    end

    def product
      @product ||= Product.find(product_id)
    end
  end
end
