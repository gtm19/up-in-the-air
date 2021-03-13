class TripParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  has_many :participant_scores, dependent: :destroy
  has_many :potential_destinations, dependent: :destroy
  has_many :date_preferences, dependent: :destroy

  def lead_user
    trip.lead_user
  end
end
