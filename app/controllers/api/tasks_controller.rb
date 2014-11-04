class API::TasksController < API::BaseController
  before_action :fetch_project, except: [:edit, :show, :destroy]

  def index
    respond_with @project.tasks
  end

  private
  def task_params
    params.require(:task).permit(:project_id, :title, :description, :state, :estimated_time, :time_spent, :deadline)
  end

  def fetch_project
    @project = Project.find(params[:project_id])
  end
end