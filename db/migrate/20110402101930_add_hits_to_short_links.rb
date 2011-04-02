class AddHitsToShortLinks < ActiveRecord::Migration
  def self.up
    add_column :short_links, :hits, :integer, :default => 0
  end

  def self.down
    remove_column :short_links, :hit
  end
end
