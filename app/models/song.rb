# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :artist
  validates :name,
            presence: true
  validates :duration,
            comparison: { greater_than: 0 },
            allow_blank: true
end
