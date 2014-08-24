# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'juco.co.uk'
set :repo_url, 'ssh://juco@juco.co.uk/git/site'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/juco/www/site'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, { path: "/home/juco/.rvm/gems/ruby-2.0.0-p353/bin:/home/juco/.rvm/rubies/ruby-2.0.0-p481/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Stop current instance'
  task :stop do
    on roles(:web) do
      puts "checking whether #{current_path} exists.."
      if execute :test, "-d #{current_path}" and test :test, "-e #{current_path}/thin.pid"
        within current_path do
          execute :thin, "stop -P #{current_path}/thin.pid"
        end
      end
    end
  end

  desc 'Restart application'
  task :start do
    on roles(:web) do
      within current_path do
        puts 'Attmpting to start thin...'
        execute :thin, '-e production -d start -P thin.pid'
      end
    end
  end

  before :starting, :stop
  after :publishing, :start
end
