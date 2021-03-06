default_run_options[:pty] = true
set :application, "denachtdienst.org"
set :user, "deploy"
set :port, 30000
set :repository,  "git@github.com:bittersweet/denachtdienst.org.git"
set :scm, "git"
set :deploy_to, "/home/deploy/sites/#{application}"
set :deploy_via, "remote_cache"

ssh_options[:forward_agent] = true
ssh_options[:username] = "deploy"
set :use_sudo, false

role :app, application
role :web, application
role :db,  application, :primary => true

namespace :deploy do	

  after "deploy:update_code", "deploy:link_production_db", "deploy:link_hoptoad_config", "deploy:link_app_config", "deploy:package_assets"

  desc "Link in the production database.yml"
  task :link_production_db do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
  
  desc "Link the hoptoad initializer file"
  task :link_hoptoad_config do
    run "ln -nfs #{deploy_to}/shared/config/initializers/hoptoad.rb #{release_path}/config/initializers/hoptoad.rb"
  end
  
  desc "Link the app_config file"
  task :link_app_config do
    run "ln -nfs #{deploy_to}/shared/config/app_config.yml #{release_path}/config/app_config.yml"
  end
  
  desc "Package CSS and JS files"
  task :package_assets do
    run "cd #{release_path} && rake asset:packager:build_all"
  end

  desc "Restarting Passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with Passenger"
    task t, :roles => :app do ; end
  end
end
