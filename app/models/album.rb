# frozen_string_literal: true

class Album < ApplicationRecord
  validates :name,
            presence: true
  validates :price,
            comparison: { greater_than: 0 },
            allow_blank: true
end
