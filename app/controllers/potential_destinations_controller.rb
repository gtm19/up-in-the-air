class PotentialDestinationsController < ApplicationController
  def index
    @potential_destination = policy_scope(Potential_destination)
  end

  def show
    @potential_destination = Potential_destination.find(params[:id])
    @potential_destination = Potential_destination.new
    authorize @potential_destination
  end

  def new
    @city = City.find(params[:id])
    @potential_destination = Potential_destination.new
    authorize @potential_destination
  end

  def create
    @potential_destination = Potential_destination.new
    @city = City.find(params[:id])
    @potential_destination.trip_participant_id = current_user
    @potential_destination.save unless @potential_destination >= 3
    authorize @potential_destination
  end
end

# trip_participant_id or user
