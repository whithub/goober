class DeviseCreateAdmins < ActiveRecord::Migration
  def self.up
    create_table(:admins) do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      t.integer  :failed_attempts, default: 0
      t.string   :unlock_token
      t.datetime :locked_at


      t.timestamps null: false
    end

    def self.down
      drop_table :admins
    end

    add_index :admins, :email,                unique: true
    add_index :admins, :reset_password_token, unique: true
    # add_index :admins, :confirmation_token,   unique: true
    # add_index :admins, :unlock_token,         unique: true
  end
end
