# encoding: utf-8
# frozen_string_literal: true

#
# Module Trackable provides a mixin to get trackable properties.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module Trackable
  extend ActiveSupport::Concern

  #
  # Formats attributes for event tracking.
  #
  def to_event_properties
    model
      .attributes
      .symbolize_keys
      .except(:created_at, :updated_at)
      .reject { |(key, _)| key =~ /(_id|title|description)\z/ }
      .reject { |(key, _)| key.in?(Rails.application.config.filter_parameters) }
      .tap { |attrs| attrs[:id] = model.id.to_param }
  end
end
