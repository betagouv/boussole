# encoding: utf-8
# frozen_string_literal: true

module Workings
  module ServiceOfferings
    class ContactsController < ApplicationController
      include ControllerHelpers

      require_feature :working

      # POST /workings/1/service_offerings/1/contacts
      def create
        load_working
        load_service_offering
        decorate_service_offering!
        build_contact

        # TODO: Service + listener
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

      def contact_params
        params[:contact] ? params.require(:contact).permit(:email_or_phone) : {}
      end
    end
  end
end
