class AddStatusIdToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :status_id, :integer, :default => Link::Pending
  end

  def self.down
    remove_column :links, :status_id
  end
end
