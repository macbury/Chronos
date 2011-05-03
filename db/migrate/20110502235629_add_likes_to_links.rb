class AddLikesToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :likes, :integer, :default => 0
    remove_column :statuses, :likes
  end

  def self.down
    remove_column :links, :likes
  end
end
