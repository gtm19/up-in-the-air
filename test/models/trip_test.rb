require 'test_helper'

class TripTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "scoring_complete returns true when all trip_participants have complete scoring" do
    trip = Trip.new

    trip.trip_participants << TripParticipant.new(scoring_complete: true)
    assert trip.scoring_complete?

    trip.trip_participants << TripParticipant.new
    assert_not trip.scoring_complete?
  end
end
