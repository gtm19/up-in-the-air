class TripParticipantsController < ApplicationController
  def destroy
    @trip = Trip.find(params[:trip_id])
    @trip_participant = TripParticipant.find(params[:id])
    authorize @trip_participant

    @trip_participant.destroy

    redirect_to trip_path(@trip)
  end
end
