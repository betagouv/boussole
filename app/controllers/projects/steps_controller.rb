class Projects::StepsController < ApplicationController
  include Wicked::Wizard

  steps *Project::STEPS

  def show
    load_project
    render_wizard
  end

  def update
    load_project
    @project.update(project_params(step))
    render_wizard(@project)
  end

  private

  def load_project
    @project ||= Project.find(params[:project_id])
  end

  def project_params(step)
    permitted_attributes = case step
      when :profile
        %i(age status city handicap)
      when :profession
        %i(profession experience)
      end

    if params[:project]
      params
        .require(:project)
        .permit(permitted_attributes)
        .merge(current_step: step)
    else
      {}
    end
  end

  # # Only allow a trusted parameter "white list" through.
  # def project_params
  #   if params[:project]
  #     params
  #       .require(:project)
  #       .permit(
  #         :last_class,
  #         :pe,
  #         :ml,
  #         :cap,
  #         :apec
  #       )
  #   else
  #     {}
  #   end
  # end

end
