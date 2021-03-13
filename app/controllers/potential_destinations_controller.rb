class PotentialDestinationsController < ApplicationController
  def index
    @trip = Trip.find(params[:trip_id])
    @trip_participant = TripParticipant.find(params[:trip_participant_id])

    if params[:budget].present?
      @trip_estimates = TripEstimate.where("high_cost < #{params[:budget]}").limit(20)
    else
      @trip_estimates = TripEstimate.limit(20)
    end

    @potential_destination = policy_scope(PotentialDestination)
  end

  # def new
  #   @city = City.find(params[:id])
  #   @potential_destination = PotentialDestination.new
  #   authorize @potential_destination
  # end

  def create
    skip_authorization
    tp = TripParticipant.find(params[:trip_participant_id])
    te = TripEstimate.find(params[:est])
    pd = PotentialDestination.new
    pd.city = te.destination_city
    pd.trip_participant = tp
    pd.status = 'selected'
    pd.save
    redirect_to trip_trip_participant_potential_destinations_path(params[:trip_id], params[:trip_participant_id])
  end

    def destroy
      skip_authorization
      tp = TripParticipant.find(params[:trip_participant_id])
      te = TripEstimate.find(params[:est])
      pd = PotentialDestination.find_by(city: te.destination_city, trip_participant: tp)
      pd.destroy

      redirect_to trip_trip_participant_potential_destinations_path(params[:trip_id], params[:trip_participant_id])

    end

    def update
      skip_authorization
      redirect_to trip_path(params[:trip_id])
    end

    private

    def params_cocktail
      params.require(:cocktail).permit(:name, :instructions, :photo_url, :photo)
    end
end
