class PotentialDestinationsController < ApplicationController
  def index
    @potential_destination = policy_scope(PotentialDestination)
  end

  def new
    @city = City.find(params[:id])
    @potential_destination = PotentialDestination.new
    authorize @potential_destination
  end

  def create
    @potential_destination = PotentialDestination.new
    @city = City.find(params[:id])
    @potential_destination.trip_participant_id = current_user
      # if @potential_destination.trip_participant.potential_destinations <= 3
        @potential_destination.save
        authorize @potential_destination
      # else
      #   render :new
      #   flash[:notice]="You have a limit of 3 destinations"
      # end
    end
end
