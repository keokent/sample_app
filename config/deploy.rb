set :application, "sample_app"
set :repository,  "https://github.com/keokent/sample_app.git"
set :user, "appuser"
ssh_options[:keys] = "~/.ssh/id_rsa"
set :scm, "git"
set :branch, :master
set :deploy_to, "/home/appuser/rails"
set :use_sudo, false
set :shared_children, %w(log pids system run)
set :rails_env, "production"


role :web, "app001.keoken.pb"   
role :app, "app001.keoken.pb"   
role :db,  "app001.keoken.pb", :primary => true


namespace :deploy do
  desc "restart unicorn"
  task :restart_unicorn do
    run "/etc/init.d/unicorn_sample_app restart"
  end

  desc "upgrade unicorn"
  task :upgrade_unicorn do
    run "sudo /etc/init.d/unicorn_sample_app upgrade"
  end
end

namespace :database do
  desc "populate"
  task :populate do
    run "cd #{current_path} && bundle exec rake db:populate"
  end
end

namespace :assets do
  desc "assets precompile"
  task :precompile do
    run "cd #{current_path} && bundle exec rake assets:precompile RAILS_ENV=#{rails_env}"
  end
end


before :deploy, "deploy:setup"
after :deploy, "deploy:upgrade_unicorn"
