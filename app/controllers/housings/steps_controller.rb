# encoding: utf-8
# frozen_string_literal: true

module Housings
  class StepsController < ApplicationController
    include Wicked::Wizard

    steps *Housing::STEPS

    require_feature :housing

    def show
      load_housing
      render_wizard
    end

    def update
      load_housing
      @housing.update(housing_params(step))

      if @housing.errors.empty?
        case step
        when :housing
          redirect_to(housing_step_path(@housing, :profile))
        when :profile
          redirect_to(finish_wizard_path)
        end
      else
        render_wizard(@housing)
      end
    end

    private

    def load_housing
      @housing ||= Housing.find(params[:housing_id])
    end

    def housing_params(step)
      permitted_attributes =
        case step
        when :housing
          %i(duration housing_city resources)
        when :profile
          %i(status residence_city age)
        end

      if params[:housing]
        params
          .require(:housing)
          .permit(permitted_attributes)
      else
        {}
      end.merge(current_step: step)
    end

    def finish_wizard_path
      housing_path(@housing)
    end
  end
end
