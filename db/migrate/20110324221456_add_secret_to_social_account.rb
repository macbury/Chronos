class AddSecretToSocialAccount < ActiveRecord::Migration
  def self.up
    add_column :social_accounts, :secret, :string
  end

  def self.down
    remove_column :social_accounts, :secret
  end
end
