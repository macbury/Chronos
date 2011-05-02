class CreateReactions < ActiveRecord::Migration
  def self.up
    create_table :reactions do |t|
      t.integer :stream_id
      t.integer :reaction_type
      t.string :uid

      t.timestamps
    end
  end

  def self.down
    drop_table :reactions
  end
end
