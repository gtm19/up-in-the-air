class CitiesController < ApplicationController
  def index
    @cities = policy_scope(City)
  end

  def show
    @city = City.find(params[:id])
    authorize @city
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
      if @potential_destination.trip_participant.potential_destinations <= 3
      @potential_destination.save
      authorize @potential_destination
      else
        render :new
        flash[:notice]="You have a limit of 3 destinations"
      end
    end
end
