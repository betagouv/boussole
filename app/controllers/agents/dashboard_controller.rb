# encoding: utf-8
# frozen_string_literal: true

module Agents
  class DashboardController < ApplicationController
    # GET /agents
    def index
      redirect_to(agents_public_services_url)
    end
  end
end
