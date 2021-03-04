class TripsController < ApplicationController
  def index
    @trips = policy_scope(Trip)
  end

  def show
  end

  def new
  end
end
