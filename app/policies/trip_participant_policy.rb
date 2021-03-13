class TripParticipantPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end
  def destroy?
    record.lead_user == user
  end
end
