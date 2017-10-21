source "https://rubygems.org"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "4.1.2"

# Use SCSS for stylesheets
gem "sass-rails", "~> 4.0.3"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.0.0"

gem "devise"

gem "haml"

gem "d3-rails"

gem "cocoon"

gem "paperclip", "~> 4.1"

gem "acts_as_commentable"

# gem 'wicked_pdf', git: 'https://github.com/mileszs/wicked_pdf.git'

gem "bootstrap-sass", "~> 3.2.0.1"

gem "bootstrap-switch-rails"

gem "acts_as_list"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem "redactor-rails"

gem "paper_trail", "~> 3.0.2"

gem "pundit"

# Use jquery as the JavaScript library
gem "jquery-rails"
gem "jquery-ui-rails"

gem "autogrow-textarea-rails", "~> 3.1.0"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"
gem "jquery-turbolinks"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 1.2"
gem "json", git: "https://github.com/flori/json.git", branch: "v1.8.6"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem "sdoc", require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "mysql2", "~> 0.3.18"

group :production do
  gem "therubyracer"
end
#gems for testing
group :development, :test do
  gem "minitest"
  gem "database_cleaner"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "guard-rspec", require: false
  gem "rspec-nc"
  gem "fuubar"
  gem "shoulda-matchers"
  gem "terminal-notifier-guard"
  gem "ruby-prof"
end

#gems for error display
group :development do
  #gem "better_errors"
  gem "capistrano-rails", "~> 1.1", require: false
  gem "capistrano-bundler", "~> 1.1", require: false
  gem "capistrano-rvm", "~> 0.1", require: false
end
