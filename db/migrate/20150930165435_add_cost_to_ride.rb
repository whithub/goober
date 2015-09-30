class AddCostToRide < ActiveRecord::Migration
  def change
    add_column :rides, :cost, :integer
  end
end
