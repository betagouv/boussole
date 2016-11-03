# encoding: utf-8
# frozen_string_literal: true

module Workings
  class ServiceOfferingsController < ApplicationController
    require_feature :working

    # GET /workings/1/service_offerings/1
    def show
      load_working
      load_service_offering
      load_public_service
      build_contact
      decorate_service_offering
    end

    private

    def load_working
      @working ||= working_scope.find(working_params)
    end

    def load_service_offering
      @service_offering ||= service_offering_scope.find(service_offering_params)
    end

    def load_public_service
      @public_service ||= @service_offering.public_service
    end

    def build_contact
      @contact ||= contact_scope.build
      @contact.attributes = contact_params
    end

    def decorate_service_offering
      @service_offering = ServiceOfferingDecorator.(@service_offering)
    end

    def working_params
      params[:working_id]
    end

    def service_offering_params
      params[:id]
    end

    def contact_params
      params[:contact] ? params.require(:contact).permit(email_or_phone: Parameters.string) : {}
    end

    def working_scope
      Working.all
    end

    def service_offering_scope
      ServiceOffering.friendly
    end

    def contact_scope
      Contact.none
    end
  end
end
