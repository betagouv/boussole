# encoding: utf-8
# frozen_string_literal: true

class VisitorsController < ApplicationController
  # Reset session for each landing page visit
  before_action :reset_session, only: :index
end
