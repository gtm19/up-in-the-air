class City < ApplicationRecord
  has_many :start_city_trip_estimates, class_name: "TripEstimate", foreign_key: "start_city_id"
  has_many :destination_city_trip_estimates, class_name: "TripEstimate", foreign_key: "destination_city_id"
  has_many :users
  has_many :potential_destinations
  has_many :trip_participants, through: :potential_destinations
  has_many :trips
end
