class Trip < ApplicationRecord
  belongs_to :lead_user, class_name: "User", foreign_key: "user_id"
  belongs_to :city, optional: true

  has_many :trip_participants, dependent: :destroy
  has_many :users, through: :trip_participants
  has_many :potential_destinations, through: :trip_participants
  has_many :participant_scores, through: :trip_participants
  has_many :date_preferences, through: :trip_participants

  validates :name, presence: true

  def scoring_complete?
    trip_participants.all?(&:scoring_complete?)
  end

  def finalised?
    [city, start_date, end_date].all?(&:present?)
  end

  def possible_dates
    date_ranges = date_preferences.map do |date_preference|
      date_preference.start_date..date_preference.end_date
    end

    dates = date_ranges.reduce do |running, new|
      running.to_a & new.to_a
    end

    dates.nil? ? [] : dates
  end
end
