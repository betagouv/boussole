# encoding: utf-8
# frozen_string_literal: true

module Workings
  module ServiceOfferings
    class ContactsController < ApplicationController
      require_feature :working

      # POST /workings/1/service_offerings/1/contacts
      def create
        load_working
        load_service_offering
        load_public_service
        build_contact

        if @contact.save
          Mailer.contact_email(@contact, @service_offering, @working).deliver_now
          redirect_to(
            working_service_offering_url(@working, @service_offering),
            notice: t(:contact, scope: 'actioncontroller.notice', response_time: @service_offering.response_time_upper_bound)
          )
        else
          render(template: 'workings/service_offerings/show')
        end
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

      def working_params
        params[:working_id]
      end

      def service_offering_params
        params[:service_offering_id]
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
end
