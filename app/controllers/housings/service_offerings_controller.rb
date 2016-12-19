# encoding: utf-8
# frozen_string_literal: true

module Housings
  class ServiceOfferingsController < ApplicationController
    include ControllerHelpers

    require_feature :housing

    # Tracking
    after_action :track_discovers_service, only: :show, unless: :blacklisted?

    # GET /housings/1/service_offerings/1
    def show
      load_housing
      load_service_offering
      load_public_service
      build_contact
    end

    private

    def track_discovers_service
      tracker.(
        :jeunes,
        :discovers_service,
        housing: @housing,
        servive_offering: @service_offering,
        public_service: @public_service
      )
    end
  end
end
