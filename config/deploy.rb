set :rvm_ruby_string, '1.9.3@rails3'
#set :rvm_type, :user  # Don't use system-wide RVM

set :user, "w2gen"
set :scm_username, "2GenRepo"
set :scm_passphrase, "12qw34as56zx"
set :use_sudo, false
set :password, "21rebeCC@$T"
set :domain, "108.59.4.77"
set :application, "Ecosynthetix Quality Application"

set :repository,  "https://2GenRepo@github.com/2GenRepo/ecosynthetix.git"

#for live app
#set :branch, "master"
set :deploy_to, "/home/w2gen/webapps/ecolive"

#for staging app
#set :branch, "master"
#set :deploy_to, "/home/w2gen/webapps/ecosynthetix"

#set :deploy_via, :remote_cache

default_run_options[:pty] = true
#set :use_sudo, false

set :scm, "git"
# Or: 'accurev', 'bzr', 'cvs', 'darcs', 'git', 'mercurial', 'perforce', 'subversion' or 'none'

role :web, domain                           # Your HTTP server, Apache/etc
role :app, domain                           # This may be the same as your 'Web' server
role :db,  domain, :primary => true         # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
#namespace :deploy do
#  task :start do ; end
#  task :stop do ; end
#  task :restart, :roles => :app, :except => { :no_release => true } do
#    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#  end
#end

namespace :deploy do
  desc "Restart nginx"
  task :restart do
    run "/bin/restart"
  end
end

#after "deploy:update_code", :bundle_install
#desc "Running the bundle install"
#task :bundle_install, :roles => :app do
#  run "cd #{release_path} && bundle install"
#end
