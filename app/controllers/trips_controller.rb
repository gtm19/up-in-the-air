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
    authorize @trip
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render "new"
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description, :start_date, :end_date, :city_id)
  end
end
