class City < ApplicationRecord
  has_many :start_city_trip_estimates, class_name: "TripEstimate", foreign_key: "start_city_id"
  has_many :destination_city_trip_estimates, class_name: "TripEstimate", foreign_key: "destination_city_id"
  has_many :users
  has_many :potential_destinations
  has_many :trip_participants, through: :potential_destinations
  has_many :trips
  has_one_attached :photo, dependent: :destroy

  validates :name, presence: true
  validates :country, presence: true

  validates_uniqueness_of :name, scope: [:country]
end
