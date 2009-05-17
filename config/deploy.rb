set :application, "btblogs"
set :scm, :git
set :repository, 'git://github.com/kerryb/btblogs.git'
set :branch, 'master'
set :user, 'btblogs'
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1 
set :use_sudo, false

host = 'barranca.dreamhost.com'
role :app, host
role :web, host
role :db,  host, :primary => true

before 'deploy:setup', 'db:create_config'
after 'deploy:update_code', 'db:symlink'

namespace :deploy do
  desc 'Removes all versions of the application from the server'
  task 'destroy' do
    run "rm -rf #{deploy_to}"
  end
  
  # Restart passenger on deploy
  desc 'Restart mod_rails with restart.txt'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

namespace :db do
  desc 'Create database.yml in shared path'
  task :create_config do
    db_config = ERB.new(File.read('config/database.yml.erb'))
    database_password = Capistrano::CLI.password_prompt 'Please enter database password'
    run "mkdir -p #{shared_path}/config"
    put db_config.result(binding), "#{shared_path}/config/database.yml"
  end

  desc 'Symlink database.yml into current path'
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

desc "Upgrade the app"
task :upgrade do
  deploy.update_code
  deploy.web.disable
  deploy.symlink
  deploy.migrate
  deploy.restart
  deploy.web.enable
  deploy.cleanup
end
