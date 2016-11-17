# encoding: utf-8
# frozen_string_literal: true

module Housings
  class ServiceOfferingsController < ApplicationController
    include ControllerHelpers

    require_feature :housing

    # GET /housings/1/service_offerings/1
    def show
      load_housing
      load_service_offering
      load_public_service
      build_contact
    end
  end
end
