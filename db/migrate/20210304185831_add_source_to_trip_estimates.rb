class AddSourceToTripEstimates < ActiveRecord::Migration[6.0]
  def change
    add_column :trip_estimates, :source, :text
  end
end
