class API::ProjectsController < API::BaseController
  before_action :current_project, only: [:show, :edit, :update, :destroy]

  def index
    respond_with Project.all
  end

  def show
    respond_with @project
  end

  def create
    project = Project.new(project_params)
    if project.save
      respond_with project, status: :created, location: api_projects_url
    else
      render json: project.errors, status: 422
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      respond_with @project, status: 200
    else
      render json: @project.errors, status: 422
    end
  end

  def destroy
    @project.destroy
    head 204
  end

  private
  def current_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:owner_id, :title, :description)
  end
end
