class Projects::StepsController < ApplicationController
  include Wicked::Wizard

  steps *Project::STEPS

  def show
    @project = Project.find(params[:project_id])
    render_wizard
  end

  def update
  end
end
