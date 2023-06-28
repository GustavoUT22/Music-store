# frozen_string_literal: true

class AlbumOrder < ApplicationRecord
  belongs_to :album
  belongs_to :order
  validates :quantity,
            comparison: { greater_than: 0 }
end
