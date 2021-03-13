class ParticipantScorePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    true
    # record.user == user
    # - record: the restaurant passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    true
    # record.user == user
  end

  def create?
    true
  end

  def show?
    true
    # record.user == user
  end
end
