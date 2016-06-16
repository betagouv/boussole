source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 4.2'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'haml-rails'
gem 'pg'
gem 'simple_form'

group :production, :staging do
  gem 'heroku_rails_deflate'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :development do
  gem 'better_errors'
  gem 'foreman'
  gem 'letter_opener_web'
  gem 'guard-bundler', require: false
  gem 'guard-bower', require: false
  gem 'guard-foreman', require: false
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
  gem 'quiet_assets'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring-commands-rspec'
  gem 'web-console'
  gem 'xray-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
end
