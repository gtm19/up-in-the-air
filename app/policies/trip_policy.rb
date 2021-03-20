class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:trip_participants).where({ trip_participants: { user: user } })
    end
  end

  def create?
    true
  end

  def show?
    record.users.include? user
  end

  def update?
    record.lead_user == user && !record.finalised?
  end
end
