# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer

  validates :total_price,
            comparison: { greater_than: 0 },
            allow_blank: true

  validates :order_date,
            comparison: { less_than: Time.zone.today }
end
