class AddVetoToParticipantScore < ActiveRecord::Migration[6.0]
  def change
    add_column :participant_scores, :veto, :boolean
  end
end
