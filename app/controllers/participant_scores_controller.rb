class ParticipantScoresController < ApplicationController

  SCORES = {
    1 => 10,
    2 => 8,
    3 => 6,
    4 => 4,
    5 => 2,
    6 => 1
  }

  def index
    @trip_participant = TripParticipant.find(params[:trip_participant_id])
    @trip = @trip_participant.trip
    create_remaining_scoring_records
    @participant_scores = ParticipantScore.where(trip_participant: @trip_participant)
    pre_position
    create_cards
    @participant_scores = policy_scope(ParticipantScore)
  end

  def move
    raise
  end

  private

  def params_scoring
    params.require(:participant_score).permit(:position)
  end

  def create_cards
    @cards = []
    @participant_scores.each do |ps|
      card = Hash.new
      card[:ps] = ps
      card[:te] = trip_estimate(ps)
      card[:budget] = rand(1.0..5.0)
      card[:time] = rand(1.0..5.0)
      card[:loved] = rand(1.0..5.0)
      card[:calender] = rand(1.0..5.0)
      card[:trip_id] = @trip.id
      card[:tp_id] = @trip_participant.id
      card[:position] = ps.position
      @cards.push(card)
    end
  end


  def create_remaining_scoring_records
    # Checking that any potential destinations are converted to participant scores

    trip_participants = TripParticipant.where(trip: @trip)

    # pss = ParticipantScore.where(trip_participant: @trip_participant)
    # position = pss.max_by { |ps| ps.position }.position
    position = 0
    potential_destinations = []
    trip_participants.each do |tp|
      potential_destinations += PotentialDestination.where(trip_participant: tp, status: "submitted")
    end

    potential_destinations.each do |pd|
      next unless ParticipantScore.find_by(potential_destination: pd).nil?

      position += 1
      ps = ParticipantScore.new(
        potential_destination: pd,
        trip_participant: @trip_participant,
        position: position,
        score: SCORES[position] || 1
        )
      ps.save
    end
  end

  def trip_estimate(participant_score)
    start_city = participant_score.trip_participant.user.city
    dest_city = participant_score.potential_destination.city
    outbound_date = DatePreference.find_by(trip_participant: participant_score.trip_participant).start_date.to_datetime || Date.parse('01-05-2021').to_datetime
    TripEstimate.where("start_city_id = #{start_city.id} AND destination_city_id = #{dest_city.id} AND valid_from <= '#{outbound_date}' AND valid_until >= '#{outbound_date}'")[0]
  end



  def pre_position
    exist = 0
    @participant_scores.each do |ps|
      exist += ps.position
    end

    if exist.zero?
      position = 1
      @participant_scores.each do |ps|
        ps.position = position
        ps.score = SCORES[position] || 2
        position += 1
        ps.save
      end
    end
  end

  def budget_rating(participant_score)
      # Get each participant
      # Get their budget
      # Determine their start city
      # Get destination city of score
      # Meet budget = 1, No means 0
  end
end
