# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'bookgame'
set :repo_url, 'git@github.com:ximes/bookgame.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/ximes/gamebook.mucchedighisa.com'

#http://www.42.mach7x.com/2014/01/09/fatal-cannot-exec-tmp-git-ssh-sh-permission-denied-capistrano-dreamhost-permission-denied-for-git-ssh-sh/
set :tmp_dir, "/home/ximes/tmp"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

require 'capistrano/rvm'
set :rvm_map_bins, %w{gem rake ruby bundle}

require 'capistrano/bundler'
set :bundle_bins, fetch(:bundle_bins, %w{rake})
set :bundle_roles, :all                                  # this is default
set :bundle_binstubs, -> { shared_path.join('bin') }     # this is default
set :bundle_gemfile, -> { release_path.join('Gemfile') } # default: nil
set :bundle_path, -> { shared_path.join('bundle') }      # this is default
set :bundle_without, %w{development test}.join(' ')      # this is default
set :bundle_flags, '--deployment --quiet'                # this is default
set :bundle_env_variables, {}                            # this is default

require 'capistrano/rails'
set :migration_role, 'db'            # Defaults to 'db'
set :assets_roles, [:web]            # Defaults to [:web]
set :assets_prefix, 'assets'         # Defaults to 'assets' this should match config.assets.prefix in your rails config/application.rb


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc "Check that we can access everything"
    task :check_write_permissions do
      on roles(:all) do |host|
        if test("[ -w #{fetch(:deploy_to)} ]")
          info "#{fetch(:deploy_to)} is writable on #{host}"
        else
          error "#{fetch(:deploy_to)} is not writable on #{host}"
        end
      end
    end
end
