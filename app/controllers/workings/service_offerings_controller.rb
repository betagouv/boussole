# encoding: utf-8
# frozen_string_literal: true

module Workings
  class ServiceOfferingsController < ApplicationController
    require_feature :working

    # GET /workings/1/service_offerings/1
    def show
      @working          = Working.find(params[:working_id])
      @service_offering = ServiceOffering.friendly.find(params[:id])
      @public_service   = @service_offering.public_service
    end
  end
end
