class ChangePasswordToBinary < ActiveRecord::Migration
  def self.up
    change_column :social_accounts, :password, :binary
  end

  def self.down
  end
end
