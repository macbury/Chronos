Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 3
Delayed::Worker.max_attempts = 5
Delayed::Worker.max_run_time = 30.seconds
Delayed::Worker.delay_jobs = !Rails.env.test?

module TaskPriority
  Auth = 10
  StatusPublish = 1
end
