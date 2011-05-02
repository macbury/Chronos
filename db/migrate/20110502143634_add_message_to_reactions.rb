class AddMessageToReactions < ActiveRecord::Migration
  def self.up
    add_column :reactions, :message, :string
  end

  def self.down
    remove_column :reactions, :message
  end
end
