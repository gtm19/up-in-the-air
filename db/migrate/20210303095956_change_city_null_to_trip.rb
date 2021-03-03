class ChangeCityNullToTrip < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:trips, :city_id, true)
  end
end
