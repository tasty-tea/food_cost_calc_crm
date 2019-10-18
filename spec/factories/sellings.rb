# frozen_string_literal: true

FactoryBot.define do
  factory :selling do
    product_id { 1 }
    user_id { 1 }
    amount { 1 }
    brake { false }
  end
end
