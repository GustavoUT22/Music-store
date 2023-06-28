# frozen_string_literal: true

class Artist < ApplicationRecord
  validates :name,
            presence: true
  validates :birth_date,
            comparison: {
              less_than: Time.zone.today,
              messages: "can't be in the future"
            },
            allow_blank: true
  # validates :death_date,
  #           comparison: {
  #             greater_than: :birth_date,
  #             messages: "can't be before birth_date"
  #           },
  #           allow_blank: true,
  #           if: :birth_date
  validate :date_validation_death_date

  private

  def date_validation_death_date
    if birth_date.nil? && !death_date.nil?
      return errors.add(:death_date,
                        "can't exits without birth_date")
    end

    return if death_date.nil?

    return errors.add(:death_date, "can't be before birth_date") if birth_date > death_date
  end
end
