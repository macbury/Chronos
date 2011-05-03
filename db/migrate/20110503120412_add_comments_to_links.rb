class AddCommentsToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :comments, :integer, :default => 0
  end

  def self.down
    remove_column :links, :comments
  end
end
