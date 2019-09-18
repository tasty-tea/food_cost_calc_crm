# frozen_string_literal: true

class Selling < ApplicationRecord
  belongs_to :product
  belongs_to :user

  scope :where_date, lambda { |item|
                       where(
                         created_at: item.beginning_of_day..item.end_of_day
                       )
                     }
end
