# frozen_string_literal: true

class Selling < ApplicationRecord
  belongs_to :product
  belongs_to :user
end
