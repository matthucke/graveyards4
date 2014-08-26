#
# Start with: 
# bundle exec unicorn -c config/unicorn.rb -D
require 'pathname'

# config.ru will look at this to support both passenger & unicorn...
env = File.read("/srv/config/graveyards4/rails_env").chomp

ENV['RAILS_ENV']  = env
ENV['IN_UNICORN'] = '1'
# ENV['RAILS_RELATIVE_URL_ROOT'] ||= '/'

# controls number of daemons and maybe other options
is_prod = (ENV['RAILS_ENV']=='production')

base_dir= File.dirname(File.dirname( Pathname.new(__FILE__).realpath.to_s ))
working_directory base_dir

pids_dir = "#{base_dir}/tmp/pids"
unless Dir.exists?(pids_dir)
  puts "mkdir #{pids_dir}"
  Dir.mkdir pids_dir, 0777
end

pid "tmp/pids/unicorn.pid"
stderr_path "log/unicorn.log"
stdout_path "log/unicorn.log"

listen "/tmp/unicorn.graveyards4.sock"
worker_processes (is_prod ? 8 : 2)
timeout 30

puts "* starting #{env} app in #{base_dir}"

