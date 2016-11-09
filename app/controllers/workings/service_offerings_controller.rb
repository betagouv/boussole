# encoding: utf-8
# frozen_string_literal: true

module Workings
  class ServiceOfferingsController < ApplicationController
    include ControllerHelpers

    require_feature :working

    # Tracking
    after_action :track_discovers_service, only: :show

    # GET /workings/1/service_offerings/1
    def show
      load_working
      load_service_offering
      load_public_service
      build_contact
    end

    private

    def load_public_service
      @public_service ||= PublicServiceDecorator.(@service_offering.public_service)
    end

    def contact_params
      params[:contact] ? params.require(:contact).permit(:email_or_phone) : {}
    end

    def track_discovers_service
      tracker.(
        :jeunes,
        :discovers_service,
        working: @working,
        servive_offering: @service_offering,
        public_service: @public_service
      )
    end
  end
end
