class AddProgressStatsToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :done, :integer, :default => 0
    add_column :links, :total, :integer, :default => 0
  end

  def self.down
    remove_column :links, :total
    remove_column :links, :done
  end
end
