class PotentialDestinationsController < ApplicationController
  def index
    skip_authorization
    @trip = Trip.find(params[:trip_id])
    @trip_participant = TripParticipant.find(params[:trip_participant_id])

    # budget = params["budget"] || 999_999
    params["budget"].present? ? budget = params["budget"].to_i : budget = 999999
    params["time"].present? ? time = params["time"].to_i : time = 999999

    puts params
    puts budget
    puts time

    @trip_estimates = TripEstimate.where("high_cost <= '#{budget}' AND start_city_id = '#{@trip_participant.user.city_id}' AND flight_mins <= '#{time}' ").limit(20)


    @cards = cards_with_love

    p @cards

    @potential_destination = policy_scope(PotentialDestination)
  end

  def create
    puts params
    skip_authorization
    pd = PotentialDestination.new
    pd.city = TripEstimate.find(params[:est]).destination_city
    pd.trip_participant = TripParticipant.find(params[:trip_participant_id])
    pd.status = 'selected'
    pd.save
    if params[:sub_action] == 'icon_click'
      # head :ok
      render json: { pd: pd.id, est: params[:est] } and return
    else
      xredirect_to trip_trip_participant_potential_destinations_path(params[:trip_id], params[:trip_participant_id])
    end
  end

  def destroy
    skip_authorization
    PotentialDestination.find(params[:id]).destroy
    if params[:sub_action] == 'icon_click'
      head :ok
    else
      redirect_to trip_trip_participant_potential_destinations_path(params[:trip_id], params[:trip_participant_id])
    end
  end

  def update
    skip_authorization
    trip_participant = TripParticipant.find(params[:trip_participant_id])
    pds = PotentialDestination.where(trip_participant: trip_participant, status: 'selected')
    pds.each do |pd|
      pd.status = 'submitted'
      pd.save
    end
    redirect_to trip_trip_participant_potential_destinations_path(params[:trip_id], params[:trip_participant_id])
  end

  private

  def cards_with_love
    cards = []
    @trip_estimates.each do |te|
      card = {}
      card[:te] = te
      card[:pd] = PotentialDestination.find_by(city: te.destination_city, trip_participant: @trip_participant)
      cards << card
    end
    cards
  end
end
