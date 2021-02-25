class TripEstimate < ApplicationRecord
  belongs_to :destination_city, class_name: "City"
  belongs_to :start_city, class_name: "City"
end
