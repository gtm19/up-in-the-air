class AddPreferencesToTripParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :trip_participants, :budget_preference, :float
    add_column :trip_participants, :time_preference, :integer
  end
end
