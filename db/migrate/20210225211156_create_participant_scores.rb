class CreateParticipantScores < ActiveRecord::Migration[6.0]
  def change
    create_table :participant_scores do |t|
      t.references :potential_destination, null: false, foreign_key: true
      t.references :trip_participant, null: false, foreign_key: true
      t.float :score

      t.timestamps
    end
  end
end
