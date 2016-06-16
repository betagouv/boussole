class ProjectsController < ApplicationController
  # before_action :set_project, only: [:show, :edit, :update]

  # # GET /projects/1
  # def show
  # end

  # # GET /projects/new
  # def new
  #   @project = Project.new
  # end

  # # GET /projects/1/edit
  # def edit
  # end

  # POST /projects
  def create
    # @project = Project.new(project_params)

    # if @project.save
    #   redirect_to wizard_path(:knowledge)
    # else
    #   render :new
    # end
    @project = Project.new
    @project.save(validate: false)
    redirect_to(project_step_path(@project, Project::STEPS.first))
  end

  # # PATCH/PUT /projects/1
  # def update
  #   if @project.update(project_params)
  #     redirect_to @project, notice: 'Project was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_project
    #   @project = Project.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def project_params
      if params[:project]
        params
          .require(:project)
          .permit(
            :knowledge,
            :profession,
            :age, :status,
            :last_class,
            :city,
            :handicap,
            :experience,
            :pe,
            :ml,
            :cap,
            :apec
          )
      else
        {}
      end
    end
end
