class AddAirportCodeToCites < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :airport_code, :string
  end
end
