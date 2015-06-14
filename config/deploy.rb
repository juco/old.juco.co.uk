# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'juco.co.uk'
set :repo_url, 'git@github.com:juco/juco.co.uk.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/juco/www/site'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

#set :default_env, { path: "/home/juco/.rvm/rubies/ruby-2.2.0/bin:/home/juco/.rvm/gems/ruby-2.2.0@global/bin:/home/juco/.rvm/gems/ruby-2.2.0/bin:$PATH" }
set :default_env, { path: "/home/juco/.rvm/rubies/ruby-2.2.0/bin:/home/juco/.rvm/gems/ruby-2.2.0/bin/:$PATH" }

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

  desc 'Compile assets'
  task :assets do
    on roles(:web) do
      within current_path do
        execute :rake, 'assets'
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

  after :updated, :stop
  after :published, :start
  after :finishing, :assets
end
