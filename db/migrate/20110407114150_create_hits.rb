class CreateHits < ActiveRecord::Migration
  def self.up
    create_table :hits do |t|
      t.integer :short_link_id
      t.string :ip

      t.timestamps
    end
  end

  def self.down
    drop_table :hits
  end
end
