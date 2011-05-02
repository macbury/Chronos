Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 3
Delayed::Worker.max_attempts = 5
Delayed::Worker.max_run_time = 30.seconds
Delayed::Worker.delay_jobs = !Rails.env.test?

module TaskPriority
  # 0 delayed paperclip
  Notification = 4
  Photo = 3
  Album = 2
  Auth = 1
  StatusPublish = 1
end

TaskFrequency = Rails.env == "development" ? 10.seconds : 1.hour
