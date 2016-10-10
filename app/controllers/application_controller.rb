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

  # Flyers
  before_action :set_cookie_flip, if: -> { request.fullpath =~ /reims1[A|B|C|D|E|F|G|H|J|K|L|N]/ }

  private

  def set_raven_context
    ::Raven.extra_context(params: params.to_hash, url: request.url)
  end

  def set_cookie_flip
    features.map { |key| cookie_strategy.switch!(key, false) }
    cookie_strategy.switch!(:housing, true)
  end

  def features
    @features ||= ::Flip::FeatureSet.instance.definitions.map(&:key)
  end

  def cookie_strategy
    @cookie_strategy ||= ::Flip::CookieStrategy.new
  end
end
