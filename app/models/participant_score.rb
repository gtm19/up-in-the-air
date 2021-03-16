class ParticipantScore < ApplicationRecord
  acts_as_list

  belongs_to :potential_destination
  belongs_to :trip_participant
end
