class AddAttributeTimesToRides < ActiveRecord::Migration
  def change
    add_column :rides, :accepted_time, :string
    add_column :rides, :pickup_time,   :string
    add_column :rides, :dropoff_time,  :string
  end
end
