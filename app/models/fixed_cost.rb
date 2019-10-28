# frozen_string_literal: true

class FixedCost < ApplicationRecord
  validates :name, :cost, presence: true
  enum frequency: { once: 0, daily: 1, weekly: 2, monthly: 3, yearly: 4 }, _prefix: :paid
end
