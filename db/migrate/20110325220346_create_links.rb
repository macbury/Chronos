class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer :update_id
      t.integer :social_account_id
      t.integer :uid

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
