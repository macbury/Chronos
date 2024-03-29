class CreateShortLinks < ActiveRecord::Migration
  def self.up
    create_table :short_links do |t|
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :short_links
  end
end
