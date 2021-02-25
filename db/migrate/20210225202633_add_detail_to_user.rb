class AddDetailToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :city, null: false, foreign_key: true
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :postcode, :string
  end
end
