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

  def update
    users = params[:trip][:user_ids] << current_user.id.to_s
    users.reject!(&:empty?)

    @trip = Trip.find(params[:id])
    @trip.user_ids = users

    redirect_to trips_path

    authorize @trip
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description)
  end
end
