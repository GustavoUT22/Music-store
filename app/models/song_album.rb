# frozen_string_literal: true

class SongAlbum < ApplicationRecord
  belongs_to :song
  belongs_to :album
end
