class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.text :body
      t.integer :streamable_id
      t.string :streamable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
