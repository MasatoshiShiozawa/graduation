class Suii < ApplicationRecord
  validates :date_friday, presence: true
  validates :weekly_closing_price, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  belongs_to :special
end
