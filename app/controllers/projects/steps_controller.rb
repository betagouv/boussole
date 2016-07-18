# encoding: utf-8
# frozen_string_literal: true

module Projects
  class StepsController < ApplicationController
    include Wicked::Wizard

    steps *Project::STEPS

    require_feature :training

    def show
      load_project
      render_wizard
    end

    # TODO: Refacto (or get rid of).
    def update
      load_project
      @project.update(project_params(step))

      if @project.errors.empty?
        case step
        when :knowledge
          if @project.knowledge == KNOWLEDGE_QUESTIONS[1]
            redirect_to(project_step_path(@project, :profile))
          else
            render_wizard(@project)
          end
        when :profile
          if @project.status.in?(['Sans activité', 'Étudiant·e (décrochage)', 'Lycéen·ne – collégien·ne (décrochage)'])
            render_wizard(@project)
          else
            redirect_to(finish_wizard_path)
          end
        else
          render_wizard(@project)
        end
      else
        render_wizard(@project)
      end
    end

    private

    def load_project
      @project ||= Project.find(params[:project_id])
    end

    def project_params(step)
      permitted_attributes =
        case step
        when :knowledge
          %i(knowledge)
        when :formation
          %i(domain formation experience)
        when :profile
          %i(age status city handicap degree last_class intention)
        when :inscriptions
          %i(pe ml cap apec)
        end

      if params[:project]
        params
          .require(:project)
          .permit(permitted_attributes)
      else
        {}
      end.merge(current_step: step)
    end

    def finish_wizard_path
      project_path(@project)
    end
  end
end
