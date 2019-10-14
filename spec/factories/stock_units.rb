# frozen_string_literal: true

FactoryBot.define do
  factory :stock_unit do
    name { Faker::Food.unique.ingredient }
    cost { 11.11 }
    amount { 42 }
    rejected { 12 }
    measure_units { 'kg' }
  end
end
