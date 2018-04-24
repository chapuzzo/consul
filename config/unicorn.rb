app_dir = File.expand_path("../..", __FILE__)

shared_dir = "#{app_dir}/shared"
working_directory app_dir

# Set unicorn options
worker_processes 4
preload_app true
timeout 30

# Path for the Unicorn socket
# listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64
listen '0.0.0.0:3000'

# Set path for logging
stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"

# Set proccess id path
pid "#{app_dir}/tmp/pids/unicorn.pid"


before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end


after_fork do |server, worker|
  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
