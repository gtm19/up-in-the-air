class ParticipantScoresController < ApplicationController

  def index
    # Find trip
    # Find all participant
    # For each participant get their scores
    @trip_participant = TripParticipant.find(params[:trip_participant_id])
    create_remaining_scoring_records(@trip_participant)
    @participant_scores = ParticipantScore.where(trip_participant: @trip_participant)
    # @trips = policy_scope(Trip)
    @participant_scores = policy_scope(ParticipantScore)
  end

  private

  def trip_params
    params.require(:trip_participants).permit(:trip_participant_id)
  end

  def create_remaining_scoring_records(trip_participant)
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
end
