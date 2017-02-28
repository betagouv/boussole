# encoding: utf-8
# frozen_string_literal: true

class VisitorsController < ApplicationController
  # Tracking
  after_action :track_visits_landing, only: :index, if: :trackable?

  private

  def track_visits_landing
    tracker.(:jeunes, :visits_landing)
  end
end
