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

role :web, "app002.keoken.pb"         # Your HTTP server, Apache/etc
role :app, "app002.keoken.pb"         # This may be the same as your `Web` server
role :db,  "app002.keoken.pb", :primary => true # This is where Rails migrations will run


namespace :deploy do
  desc "restart unicorn"
  task :restart_unicorn do
    run "/etc/init.d/unicorn_sample_app restart"
  end

  desc "upgrade unicorn"
  task :upgrade_unicorn do
    run "/etc/init.d/unicorn_sample_app upgrade"
  end
end

after :deploy, "deploy:upgrade_unicorn"
