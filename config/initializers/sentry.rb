# encoding: utf-8
# frozen_string_literal: true

Raven.configure do |config|
  config.dsn                 = ENV['SENTRY_DSN']
  config.environments        = %w(production)
  config.excluded_exceptions = []
  config.sanitize_fields     = Rails.application.config.filter_parameters.map(&:to_s)
end
