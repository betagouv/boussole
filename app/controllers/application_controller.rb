# encoding: utf-8
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Feature sets
  include Flip::ControllerFilters

  # Bug tracking
  before_action :set_raven_context

  # Uptime Robot
  before_action :return_ok, if: -> { request.user_agent =~ /uptimerobot/i }

  private

  def set_raven_context
    ::Raven.extra_context(params: params.to_hash, url: request.url)
  end

  def return_ok
    head(:ok)
  end

  def features
    @features ||= ::Flip::FeatureSet.instance.definitions.map(&:key)
  end

  def tracker
    @tracker ||=
      EventTracker.new(
        session[:session_id],
        features,
        request_referer: request.referer,
        request_fullpath: request.fullpath,
        request_user_agent: request.user_agent
      )
  end

  # Lograge
  # TODO: Move to concern.
  def append_info_to_payload(payload)
    super
    payload[:session_id] = session[:session_id]
    payload[:params]     =
      request
      .filtered_parameters
      .except('controller', 'action', 'format', 'utf8')
  end
end
