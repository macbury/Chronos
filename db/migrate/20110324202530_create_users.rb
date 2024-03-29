class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :api_token

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
