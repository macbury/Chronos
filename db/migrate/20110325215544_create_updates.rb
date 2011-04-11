class CreateUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates do |t|
      t.string :title
      t.text :body
      t.string :url
      t.string :tags
      t.integer :user_id
      t.datetime :publish_at

      t.timestamps
    end
  end

  def self.down
    drop_table :updates
  end
end
