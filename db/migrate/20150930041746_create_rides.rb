class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.references :user, index: true
      t.references :admin, index: true
      t.integer    :status, default: 0
      t.string     :pick_up_location
      t.string     :drop_off_location
      t.integer    :num_of_passengers

      t.timestamps null: false
    end
  end
end
