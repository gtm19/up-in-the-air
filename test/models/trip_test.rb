require 'test_helper'

class TripTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "scoring_complete" do
    trip = Trip.new

    trip.trip_participants << TripParticipant.new(scoring_complete: true)
    assert trip.scoring_complete?

    trip.trip_participants << TripParticipant.new
    assert_not trip.scoring_complete?
  end

  test "finalised" do
    trip = Trip.new

    assert_not trip.finalised?

    city = City.new
    trip.city = city
    trip.end_date = Date.today
    trip.start_date = trip.end_date - 14
    assert trip.finalised?
  end
end
