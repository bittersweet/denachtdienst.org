default_run_options[:pty] = true
set :application, "denachtdienst.org"
set :user, "deploy"
set :port, 30000
set :repository,  "git@github.com:bittersweet/denachtdienst.org.git"
set :scm, "git"

ssh_options[:forward_agent] = true
ssh_options[:username] = "deploy"
# ssh_options[:host_key] = %w("/Users/markmulder/.ssh/id_rsa")
set :use_sudo, false

set :deploy_to, "/home/deploy/sites/#{application}"

role :app, "213.163.66.221"
role :web, "213.163.66.221"
role :db,  "213.163.66.221", :primary => true

set :deploy_via, "remote_cache"

desc "After updating code we need to populate a new database.yml"
task :after_update_code, :roles => :app do
  require "yaml"
  set :production_database_password, proc { Capistrano::CLI.password_prompt("Production database remote Password : ") }

  buffer = YAML::load_file('config/database.example.yml')
  # get ride of unneeded configurations
  buffer.delete('test')
  buffer.delete('development')
  
  # Populate production element
  buffer['production']['adapter'] = "mysql"
  buffer['production']['database'] = "dndorg_prod"
  buffer['production']['username'] = "dnd"
  buffer['production']['password'] = production_database_password
  buffer['production']['host'] = "localhost"
  
  put YAML::dump(buffer), "#{release_path}/config/database.yml", :mode => 0664
end

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"

namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do passenger.restart end }
end