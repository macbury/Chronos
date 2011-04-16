class ChangeUidColumnInLink < ActiveRecord::Migration
  def self.up
    change_column :links, :uid, :string
  end

  def self.down
  end
end
