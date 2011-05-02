class AddSocialAccountToReactions < ActiveRecord::Migration
  def self.up
    add_column :reactions, :social_account_id, :integer
  end

  def self.down
    remove_column :reactions, :social_account_id
  end
end
