# encoding: utf-8
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Flip::ControllerFilters
  include BugTracking
  include EventTracking
  include Logging

  # Uptime Robot
  before_action :ok, if: -> { request.user_agent =~ /uptimerobot/i }

  private

  def ok
    head(:ok)
  end
end
