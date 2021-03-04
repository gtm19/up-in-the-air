class AddPositionToParticipantScores < ActiveRecord::Migration[6.0]
  def change
    add_column :participant_scores, :position, :integer
  end
end
