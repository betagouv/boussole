# encoding: utf-8
# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 4.2'
gem 'pg'

gem 'coffee-rails'
gem 'flip'
gem 'friendly_id'
gem 'haml-rails'
gem 'jquery-rails'
gem 'puma'
gem 'rails-i18n'
gem 'sass-rails'
gem 'simple_form'
gem 'stronger_parameters'
gem 'turbolinks'
gem 'uglifier'
gem 'wicked'

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
  gem 'spring'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false, git: 'https://github.com/rubysec/bundler-audit.git'
  gem 'dawnscanner', require: false
  gem 'foreman'
  gem 'haml-lint', require: false
  gem 'inch', require: false
  gem 'i18n-tasks', require: false
  gem 'letter_opener_web'
  gem 'git-version-bump', require: false
  gem 'github_changelog_generator', require: false
  gem 'guard-bundler', require: false
  gem 'guard-bower', require: false
  gem 'guard-foreman', require: false
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
  gem 'quiet_assets'
  gem 'rails-erd'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'scss_lint', require: false
  gem 'spring-commands-rspec'
  gem 'web-console'
  gem 'yaml-lint', require: false
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers', '~> 3.1'
end
