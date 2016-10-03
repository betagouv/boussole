# encoding: utf-8
# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/email/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver      = :poltergeist
Capybara.asset_host             = "http://localhost:#{ENV['PORT'] || 5000}"
Capybara.server_host            = 'localhost'
Capybara.server_port            = 12_345
Capybara.run_server             = true
Capybara.ignore_hidden_elements = true
Capybara.default_max_wait_time  = 5

Capybara.register_driver(:poltergeist) do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    debug: false,
    # TODO: Mock Raven/Sentry call and re-enable JavaScript errors.
    js_errors: false,
    phantomjs_options: [
      '--load-images=no',
      '--ignore-ssl-errors=yes',
      '--ssl-protocol=any',
      '--web-security=true'
    ]
  )
end

# Working with job stories.
RSpec.configure do |config|
  %w(solution situation).each do |example, options = { capybara_feature: true, type: :feature }|
    config.alias_example_group_to(example, **options)
    config.alias_example_group_to("f#{example}", focus: true, **options)
    config.alias_example_group_to("x#{example}", skip: "Temporarily disabled with x#{example}", **options)
  end
end
