class AddCityToTrips < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :city, null: false, foreign_key: true
  end
end
