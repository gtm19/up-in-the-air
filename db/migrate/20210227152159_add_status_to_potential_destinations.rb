class AddStatusToPotentialDestinations < ActiveRecord::Migration[6.0]
  def change
    add_column :potential_destinations, :status, :string
  end
end
