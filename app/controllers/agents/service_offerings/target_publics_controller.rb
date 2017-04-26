# encoding: utf-8
# frozen_string_literal: true

module Agents
  module ServiceOfferings
    class TargetPublicsController < ApplicationController
      include ControllerHelpers
      include Pundit

      require_feature :define_target_public

      # GET /agents/service_offerings/:service_offering_id/target_public
      def show
        load_service_offering
        build_target_public
      end

      # PATCH /agents/service_offerings/:service_offering_id/target_public
      def update
        load_service_offering
        build_target_public

        if @target_public.save
          redirect_to(
            agents_service_offering_target_public_url(@service_offering),
            notice: t(:update, scope: 'actioncontroller.notice', model: TargetPublic.model_name.human)
          )
        else
          render(:show)
        end
      end

      private

      def build_target_public
        @target_public ||= TargetPublicDecorator.(@service_offering.target_public)
        @target_public.build_working_age unless @target_public.working_age.try(:persisted?)
        @target_public.build_housing_age unless @target_public.housing_age.try(:persisted?)
        @target_public.build_resource unless @target_public.resource.try(:persisted?)
        @target_public.attributes = target_public_params
      end

      def target_public_params
        if params[:target_public]
          params
            .require(:target_public)
            .permit(
              apec_ids: [],
              awareness_ids: [],
              cap_emploi_ids: [],
              engagement_ids: [],
              experience_ids: [],
              handicap_ids: [],
              housing_duration_ids: [],
              housing_status_ids: [],
              last_class_ids: [],
              mission_locale_ids: [],
              pole_emploi_ids: [],
              working_duration_ids: [],
              working_status_ids: [],
              working_age_attributes: %i(id minimum maximum),
              housing_age_attributes: %i(id minimum maximum),
              resource_attributes: %i(id minimum maximum)
            )
        else
          {}
        end
      end

      def pundit_user; end
    end
  end
end
