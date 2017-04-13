module Agents
  module ServiceOfferings
    class TargetPublicsController < ApplicationController
      before_action :set_service_offering

      # GET /agents/service_offerings/:service_offering_id/target_public
      def show
        @target_public = @service_offering.target_public
      end

      # POST /agents/service_offerings/:service_offering_id/target_public
      def create
        @target_public = TargetPublic.new(target_public_params)
        @target_public.service_offering = @service_offering
        @target_public.save

        redirect_to
      end

      # PATCH /agents/service_offerings/:service_offering_id/target_public
      def update
      end

      private

      # Only allow a trusted parameter "white list" through.
      def target_public_params
        params
          .require(:target_public)
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
      def set_target_public
        @target_public = TargetPublic.find(params[:id])
      end

      def set_service_offering
        @service_offering = service_offering_scope.find(params[:service_offering_id])
      end

    end
  end
end
