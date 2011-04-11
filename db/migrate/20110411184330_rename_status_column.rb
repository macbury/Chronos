class RenameStatusColumn < ActiveRecord::Migration
  def self.up
    rename_column :links, :status_id, :status_type
  end

  def self.down
  end
end
