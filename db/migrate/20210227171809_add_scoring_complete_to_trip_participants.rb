class AddScoringCompleteToTripParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :trip_participants, :scoring_complete, :boolean
  end
end
