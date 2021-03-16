class CitiesController < ApplicationController
  def index
    @cities = policy_scope(City)
  end

  def show
    @city = City.find(params[:id])
    @trip_estimate = TripEstimate.find(params[:id])
    authorize @city
  end
end
