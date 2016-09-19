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

  private

  def set_raven_context
    ::Raven.extra_context(params: params.to_hash, url: request.url)
  end
end
