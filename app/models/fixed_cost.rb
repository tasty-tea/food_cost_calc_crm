# frozen_string_literal: true

class FixedCost < ApplicationRecord
  enum frequency: %i[once daily weekly monthly yearly]
end
