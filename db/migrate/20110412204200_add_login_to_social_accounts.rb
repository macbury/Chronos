class AddLoginToSocialAccounts < ActiveRecord::Migration
  def self.up
    add_column :social_accounts, :login, :string
    add_column :social_accounts, :password, :string
  end

  def self.down
    remove_column :social_accounts, :password
    remove_column :social_accounts, :login
  end
end
