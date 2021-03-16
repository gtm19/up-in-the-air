class AddDefaultToVetoInParticipantScore < ActiveRecord::Migration[6.0]
  def change
    change_column_default :participant_scores, :veto, false
  end
end
