class AddReferrerToHits < ActiveRecord::Migration
  def self.up
    add_column :hits, :referrer, :string
  end

  def self.down
    remove_column :hits, :referrer
  end
end
