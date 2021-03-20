class TripParticipantsController < ApplicationController
  def destroy
    @trip = Trip.find(params[:trip_id])
    @trip_participant = TripParticipant.find(params[:id])
    authorize @trip_participant

    @trip_participant.destroy

    redirect_to trip_path(@trip)
  end

  def update
    skip_authorization
    puts params
    @trip_participant = TripParticipant.find(params[:id])
    @trip_participant.time_preference = params[:time_preference]
    @trip_participant.budget_preference = params[:budget_preference]
    @trip_participant.save
    update_date_pref
    if params[:sub_action] == 'icon_click'
      head :ok
    end
  end

  private

  def params_tp
    params.require(:trip_participant).permit(:budget_preference, :time_preference)
  end

  def update_date_pref
    dp = @trip_participant.date_preferences.all.first
    dp = DatePreference.new unless dp
    dp.trip_participant_id = @trip_participant.id
    dp.start_date = Date.parse(params[:out_date]) unless params[:out_date].empty?
    dp.end_date = Date.parse(params[:in_date]) unless params[:in_date].empty?
    dp.start_date = Date.parse('01-05-2021') if dp.start_date.nil?
    dp.end_date = Date.parse('01-05-2022') if dp.end_date.nil?
    dp.save
  end
end
