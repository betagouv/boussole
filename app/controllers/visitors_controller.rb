# encoding: utf-8
# frozen_string_literal: true

class VisitorsController < ApplicationController
  # Flyers
  before_action :set_cookie_flip, only: :index, if: -> { request.fullpath =~ /reims1[A|B|C|D|E|F|G|H|J|K|L|N]/ }
  before_action :unset_cookie_flip, only: :index, unless: -> { request.fullpath =~ /reims1[A|B|C|D|E|F|G|H|J|K|L|N]/ }

  # Tracking
  after_action :track_visits_landing, only: :index

  private

  def set_cookie_flip
    features.map { |key| cookie_strategy.switch!(key, false) }
    cookie_strategy.switch!(:housing, true)
  end

  def unset_cookie_flip
    features.map { |key| cookie_strategy.delete!(key) }
  end

  def cookie_strategy
    @cookie_strategy ||= ::Flip::CookieStrategy.new
  end

  def track_visits_landing
    tracker.(:jeunes, :visits_landing)
  end
end
