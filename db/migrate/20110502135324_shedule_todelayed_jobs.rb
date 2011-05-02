class SheduleTodelayedJobs < ActiveRecord::Migration
  def self.up
    add_column :delayed_jobs, :run_every, :datetime
  end

  def self.down
  end
end
