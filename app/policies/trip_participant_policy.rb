class TripParticipantPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end
  def destroy?
    # only lead user can destroy a participant, if the trip
    # is not yet finalised
    record.trip_lead_user == user && !record.trip.finalised?
  end

  def update?
    true
  end
end
