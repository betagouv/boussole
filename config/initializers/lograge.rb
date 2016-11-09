# encoding: utf-8
# frozen_string_literal: true

Rails.application.configure do
  if config.respond_to?(:lograge)
    config.colorize_logging       = false
    config.lograge.enabled        = true
    config.lograge.custom_options = lambda do |event|
      {
        time: event.time.as_json,
        user_agent: event.payload[:user_agent].presence || 'nil',
        session_id: event.payload[:session_id].presence || 'nil',
        params: event.payload[:params].presence || 'nil'
      }
    end
  end
end
