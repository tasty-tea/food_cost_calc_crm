# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    name { Faker::Beer.unique.name }
    cost { 99.99 }
    servings { 1 }
    estimated_sold { 0 }
    is_unit_economics { false }
  end
end
