source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5.x'
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
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :development do
  gem 'better_errors'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
