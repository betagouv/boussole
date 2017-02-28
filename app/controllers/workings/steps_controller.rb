# encoding: utf-8
# frozen_string_literal: true

module Workings
  class StepsController < ApplicationController
    include Wicked::Wizard

    steps *Working::STEPS

    def show
      load_working
      render_wizard
    end

    def update
      load_working
      @working.update(working_params(step))

      if @working.errors.empty?
        case step
        when :awareness
          redirect_to(working_step_path(@working, :project))

        when :project
          redirect_to(working_step_path(@working, :situation))

        when :situation
          redirect_to(working_step_path(@working, :inscriptions))

        when :inscriptions
          redirect_to(finish_wizard_path)
        end
      else
        render_wizard(@working)
      end
    end

    private

    def load_working
      @working ||= Working.find(params[:working_id])
    end

    def working_params(step)
      permitted_attributes =
        case step
        when :awareness
          %i(awareness)
        when :project
          %i(sector experience duration engagement)
        when :situation
          %i(status age handicap last_class city)
        when :inscriptions
          %i(pole_emploi mission_locale cap_emploi apec)
        end

      if params[:working]
        params
          .require(:working)
          .permit(permitted_attributes)
      else
        {}
      end.merge(current_step: step)
    end

    def finish_wizard_path
      working_path(@working)
    end
  end
end
