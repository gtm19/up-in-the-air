class TripsController < ApplicationController
  def index
    @trips = policy_scope(Trip)
  end

  def show
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.lead_user = current_user
    if @trip.save && @trip.users << current_user
      redirect_to trip_path(@trip)
    else
      render "new"
    end
    authorize @trip
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description)
  end
end
