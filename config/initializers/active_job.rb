Rails.application.configure do
  # Use sidekiq to process Active Jobs (e.g. ActionMailer's deliver_later)
  config.active_job.queue_adapter = :sidekiq
end
