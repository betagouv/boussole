# encoding: utf-8
# frozen_string_literal: true

require 'capybara/rails'
# require 'capybara/email/rspec'
require 'capybara/poltergeist'
# require 'capybara-screenshot/rspec'

Capybara.javascript_driver      = :poltergeist
Capybara.asset_host             = "http://localhost:#{ENV['PORT'] || 5000}"
Capybara.server_host            = 'localhost'
Capybara.server_port            = 12_345
Capybara.run_server             = true
Capybara.ignore_hidden_elements = true
Capybara.default_max_wait_time  = 30

Capybara.register_driver(:poltergeist) do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    debug: false,
    js_errors: true,
    phantomjs_options: [
      '--load-images=no',
      '--ignore-ssl-errors=yes',
      '--ssl-protocol=any',
      '--web-security=true'
    ]
  )
end
