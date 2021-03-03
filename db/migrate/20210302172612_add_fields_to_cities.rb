class AddFieldsToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :gmt, :string
    add_column :cities, :city_iata_code, :string
    add_column :cities, :country_iso2, :string
    add_column :cities, :airport_name, :string
    add_column :cities, :country_name, :string
    add_column :cities, :timezone, :string
  end
end
