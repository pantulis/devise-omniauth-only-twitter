class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :nickname
      t.string :name
      
      t.rememberable
      t.string :remember_token
      
      t.trackable
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
