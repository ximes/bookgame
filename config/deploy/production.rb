set :application, 'bookgame'
set :repo_url, 'git@github.com:ximes/bookgame.git'

set :rails_env, 'production'

set :rvm_ruby_version, '2.1.2'
set :rvm_type, :system

set :deploy_to, "/srv/rails/bookgame/"

server 'seesaw.it', user: 'deploy', roles: %w{web app db workers}

role :app, %w{deploy@seesaw.it}
role :web, %w{deploy@seesaw.it}
role :db,  %w{deploy@seesaw.it}