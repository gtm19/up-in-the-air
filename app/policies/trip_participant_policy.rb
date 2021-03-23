class TripParticipantPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end
  def destroy?
    # only lead user can destroy a participant, if the trip
    # is not yet finalised, and if the user has not
    # selected any potential destinations
    record.trip_lead_user == user &&
      record.potential_destinations.empty? &&
      !record.trip.finalised?
  end

  def update?
    true
  end
end
