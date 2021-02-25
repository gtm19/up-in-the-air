class TripParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :potential_destinations
  has_many :participant_scores
end
