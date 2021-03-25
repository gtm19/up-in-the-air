class TripsController < ApplicationController
  def index
    @trips = policy_scope(Trip)
  end

  def show
    @trip = Trip.find(params[:id])
    authorize @trip
    @trip_participants = @trip.trip_participants
    @participant_scores = @trip.participant_scores
      .select("potential_destination_id, sum(score) as score")
      .where(veto: false)
      .group(:potential_destination_id)
      .order("score DESC")
      .limit(3)
    @possible_dates = @trip.possible_dates
  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    authorize @trip
    @trip.lead_user = current_user
    if @trip.save && @trip.users << current_user
      redirect_to trip_path(@trip)
    else
      render "new"
    end
  end

  def update
    @trip = Trip.find(params[:id])
    authorize @trip

    if params[:trip][:user_ids]
      users = params[:trip][:user_ids] << current_user.id.to_s
      users.reject!(&:empty?)
      @trip.user_ids = users
    end

    @trip.update(trip_params)

    redirect_to trip_path(@trip)
  end

  private

  def trip_params
    params.require(:trip).permit(
      :name,
      :description,
      :city_id,
      :start_date,
      :end_date
    )
  end
end
