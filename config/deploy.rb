set :application, "sample_app"
set :repository,  "https://github.com/keokent/sample_app.git"
set :user, ""
ssh_options[:keys] = "~/.ssh/id_rsa"
set :scm, "git"
set :branch, :master
set :deploy_to, "/tmp/keoken"
role :web, "app001.keoken.pb"         # Your HTTP server, Apache/etc
role :app, "app001.keoken.pb"         # This may be the same as your `Web` server
role :db,  "app001.keoken.pb", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

task :clone_app do
  run "git clone https://github.com/keokent/sample_app.git /tmp/sample_app"
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
