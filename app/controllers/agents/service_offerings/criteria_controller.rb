module Agents
  module ServiceOfferings
    class CriteriaController < ApplicationController
      before_action :set_service_offering

      # GET /agents/service_offerings/:service_offering_id/criteria
      def index
        @criteria = Criterium.all
      end


      # GET /agents/service_offerings/:service_offering_id/criteria/new
      def new
        @criterium = Criterium.new
      end

      # POST /agents/service_offerings/:service_offering_id/criteria
      def create
        @criterium = Criterium.new(criterium_params)
        @criterium.service_offering = @service_offering
        @criterium.save

        redirect_to
      end

      private

      # Only allow a trusted parameter "white list" through.
      def criterium_params
        params
          .require(:criterium)
            .permit(
              :id,
              :service_offering_id
              )
      end

      def service_offering_params
        params
          .require(:service_offering)
          .permit(
            :id,
            :title,
            :public_service_id,
            :description,
            :postal_address,
            :email,
            :phone,
            :url,
            :response_time_upper_bound,
            social_right_ids: []
          )
      end

      def service_offering_scope
        ServiceOffering.friendly
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_criterium
        @criterium = Criterium.find(params[:id])
      end

      def set_service_offering
        @service_offering = service_offering_scope.find(params[:service_offering_id])
      end

    end
  end
end
