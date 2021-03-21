class PotentialDestinationsController < ApplicationController
  def index
    skip_authorization
    @trip = Trip.find(params[:trip_id])
    @trip_participant = TripParticipant.find(params[:trip_participant_id])

    @trip_participant.budget_preference.to_i.positive? ? default_budget = @trip_participant.budget_preference.to_i : default_budget = 1000
    @trip_participant.time_preference.to_i.positive? ? default_time = @trip_participant.time_preference.to_i : default_time = 800

    params["budget"].present? ? budget = params["budget"].to_i : budget = default_budget
    params["time"].present? ? time = params["time"].to_i : time = default_time

    @budget = budget
    @time = time
    default_dates


    puts params
    puts "Budget #{budget}"
    puts "Time #{time}"
    puts params["search_city"]
    puts "@budget #{@budget}"
    puts "@time #{@time}"

    if params[:search_city].present?
      puts "Searching city"
      search = "%#{params[:search_city]}%"
      @trip_estimates = TripEstimate.joins(:destination_city).where("high_cost <= '#{budget}' AND start_city_id = '#{@trip_participant.user.city_id}' AND flight_mins <= '#{time}' AND cities.name ILIKE '#{search}' ").limit(30)
    else
      @trip_estimates = TripEstimate.where("high_cost <= '#{budget}' AND start_city_id = '#{@trip_participant.user.city_id}' AND flight_mins <= '#{time}' ").limit(30)
    end
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
      redirect_to trip_trip_participant_potential_destinations_path(params[:trip_id], params[:trip_participant_id])
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
      card[:already] = @trip.potential_destinations.find_all {|i| i.trip_participant_id != @trip_participant.id && i.status == "submitted" && i.city_id == te.destination_city.id }.count
      # puts card[:already]
      cards << card
    end
    cards
  end

  def default_dates
    if params["out_date"].present?
      @o_date = params["out_date"]
    else
      @o_date = @trip_participant.date_preferences.first.start_date unless @trip_participant.date_preferences.first.nil?
    end

    if params["in_date"].present?
      @i_date = params["in_date"]
    else
      @i_date = @trip_participant.date_preferences.first.end_date unless @trip_participant.date_preferences.first.nil?
    end
  end
end
