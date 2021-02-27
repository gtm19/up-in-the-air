class DatePreference < ApplicationRecord
  belongs_to :trip_participant

  validates :start_date, presence: true
  validates :end_date, presence: true
end
