class TripParticipantsController < ApplicationController
  def destroy
    @trip = params[:trip_id]
    @trip_participant = TripParticipant.find(params[:id])
    @trip_participant.destroy

    authorize @trip

    redirect_to trip_path(@trip)
  end
end
