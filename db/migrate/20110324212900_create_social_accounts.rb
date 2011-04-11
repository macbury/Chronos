class CreateSocialAccounts < ActiveRecord::Migration
  def self.up
    create_table :social_accounts do |t|
      t.integer :user_id
      t.string :token
      t.integer :uid, :limit => 8
      t.integer :social_type
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :social_accounts
  end
end
