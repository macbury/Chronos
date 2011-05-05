class AddUnreadToReactions < ActiveRecord::Migration
  def self.up
    add_column :reactions, :unread, :boolean, :default => true
  end

  def self.down
    remove_column :reactions, :unread
  end
end
