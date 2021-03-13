class ParticipantScore < ApplicationRecord
  acts_as_list

  belongs_to :potential_destination, optional: true
  belongs_to :trip_participant
end
