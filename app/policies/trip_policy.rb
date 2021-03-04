class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:trip_participants).where({ trip_participants: { user: user } })
    end
  end
end
