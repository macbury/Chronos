class AddStatusMessageToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :status_message, :string
  end

  def self.down
    remove_column :links, :status_message
  end
end
