# frozen_string_literal: true

threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count
workers 16
worker_timeout 50

preload_app!

before_fork do
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_worker_fork do
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
