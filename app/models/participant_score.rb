class ParticipantScore < ApplicationRecord
  belongs_to :potential_destination
  belongs_to :trip_participant
end
