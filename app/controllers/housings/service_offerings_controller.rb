# encoding: utf-8
# frozen_string_literal: true

module Housings
  class ServiceOfferingsController < ApplicationController
    # GET /housings/1/service_offerings/1
    def show
      @housing          = Housing.find(params[:housing_id])
      @service_offering = ServiceOffering.friendly.find(params[:id])
      @public_service   = @service_offering.public_service
    end
  end
end
