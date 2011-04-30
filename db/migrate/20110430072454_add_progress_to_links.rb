class AddProgressToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :progress, :integer, :default => 0
  end

  def self.down
    remove_column :links, :progress
  end
end
