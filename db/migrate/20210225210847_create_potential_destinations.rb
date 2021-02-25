class CreatePotentialDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :potential_destinations do |t|
      t.references :city, null: false, foreign_key: true
      t.references :trip_participant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
