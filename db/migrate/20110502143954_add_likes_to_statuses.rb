class AddLikesToStatuses < ActiveRecord::Migration
  def self.up
    add_column :statuses, :likes, :integer, :default => 0
  end

  def self.down
    remove_column :statuses, :likes
  end
end
