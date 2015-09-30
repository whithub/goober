class AddAttributesToAdmin < ActiveRecord::Migration
  def change

    add_column :admins, :name, :string
    add_column :admins, :phone_number, :string
    add_column :admins, :car_make, :string
    add_column :admins, :car_model, :string
    add_column :admins, :car_passenger_capacity, :integer

  end
end
