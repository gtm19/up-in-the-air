class CreateTripEstimates < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_estimates do |t|
      t.float :low_cost
      t.float :high_cost
      t.integer :flight_mins
      t.datetime :valid_from
      t.datetime :valid_until
      t.references :start_city, foreign_key: { to_table: 'cities' }
      t.references :destination_city, foreign_key: { to_table: 'cities' }

      t.timestamps
    end
  end
end
