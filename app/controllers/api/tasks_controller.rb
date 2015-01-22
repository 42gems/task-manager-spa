class API::TasksController < API::BaseController
  before_action :fetch_project, except: [:edit, :show, :destroy]

  def index
    @tasks = @project.tasks
  end

  private
  def task_params
    params.require(:task).permit(:project_id, :title, :description, :state,
                                 :estimated_date, :estimated_time, :deadline, :assignee_id)
  end

  def fetch_project
    @project = Project.find(params[:project_id])
  end
end