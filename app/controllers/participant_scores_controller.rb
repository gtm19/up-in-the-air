class ParticipantScoresController < ApplicationController

  def index
    # Find trip
    # Find all participant
    # For each participant get their scores
    @cards = []
    @trip_participant = TripParticipant.find(params[:trip_participant_id])
    create_remaining_scoring_records(@trip_participant)
    @participant_scores = ParticipantScore.where(trip_participant: @trip_participant)
    @participant_scores.each do |ps|
      card = Hash.new
      card[:ps] = ps
      card[:te] = trip_estimate(ps)
      @cards.push(card)
    end
    @participant_scores = policy_scope(ParticipantScore)
  end

  private

  def trip_params
    params.require(:trip_participants).permit(:trip_participant_id)
  end

  def create_remaining_scoring_records(trip_participant)
    # Checking that any potential destinations are converted to participant scores
    @trip = trip_participant.trip
    trip_participants = TripParticipant.where(trip: @trip)
    potential_destinations = []

    trip_participants.each do |tp|
      potential_destinations += PotentialDestination.where(trip_participant: tp, status: "submitted")
    end

    potential_destinations.each do |pd|
      next unless ParticipantScore.find_by(potential_destination: pd).nil?

      ps = ParticipantScore.new(
        potential_destination: pd,
        trip_participant: trip_participant,
        position: 0,
        score: 0
        )
      ps.save
    end
  end

  def trip_estimate(participant_score)
    # TODO - Fixed the search to search by date range.
    start_city = participant_score.trip_participant.user.city
    dest_city = participant_score.potential_destination.city
    # outbound_date = DatePreference.find_by(trip_participant: participant_score.trip_participant).start_date.to_datetime || Date.parse('01-05-2021').to_datetime
    # TripEstimate.where("start_city_id = #{start_city.id} AND destination_city_id = #{dest_city.id} AND valid_from <= #{outbound_date} AND valid_until >= #{outbound_date}")[0]
    TripEstimate.where("start_city_id = #{start_city.id} AND destination_city_id = #{dest_city.id}")[0]
  end
end
