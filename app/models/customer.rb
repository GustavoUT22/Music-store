# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :username,
            presence: true,
            uniqueness: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/ }
  validates :password,
            presence: true,
            format: { with: /\A(?=.*\d).{6,}\z/ }
end
