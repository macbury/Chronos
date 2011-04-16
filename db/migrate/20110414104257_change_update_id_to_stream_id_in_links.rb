class ChangeUpdateIdToStreamIdInLinks < ActiveRecord::Migration
  def self.up
    rename_column :links, :update_id, :stream_id
  end

  def self.down
  end
end
