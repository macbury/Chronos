set :application, "chronos"
role :app, "tz.rhmusic.pl"
role :web, "tz.rhmusic.pl"
role :db,  "tz.rhmusic.pl", :primary => true

set :repository,  "git@macbury.unfuddle.com:macbury/chronos.git"

set :branch, "master"
set :user, "root"
set :scm, :git
set :deploy_to, "/home/krzyz/#{application}/"
set :rails_env, "production"

after 'deploy:symlink', 'deploy:symlink_shared'
after 'deploy:symlink_shared', 'deploy:bundle'
after 'deploy:symlink_shared', 'deploy:migrate'
after 'deploy:symlink_shared', 'deploy:delay_job'

namespace :deploy do
  desc "Tell Passenger to restart the app."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/rhcore.yml #{release_path}/config/rhcore.yml"
    run "ln -nfs #{shared_path}/config/providers.yml #{release_path}/config/providers.yml"
  end
  
  desc "Sync the public/assets directory."
  task :assets do
    system "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{application}:#{shared_path}/"
  end

  desc "Install bundles"
  task :bundle do
    run "cd #{release_path} && bundle install --path=#{shared_path}/bundle"
  end
  
  task :migrate do
    run "cd #{current_path} && rake db:migrate RAILS_ENV=production && rake db:seed RAILS_ENV=production" 
  end
  
  task :delay_job do
    run "cd #{current_path} && RAILS_ENV=production script/delayed_job start"
    run "cd #{current_path} && RAILS_ENV=production script/delayed_job stop"
    
  end
end