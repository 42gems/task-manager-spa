class API::TasksController < API::BaseController
  belongs_to :project,  class_name: "Project"
  before_action :current_task, only: [:show, :edit, :update, :destroy]
  
  def index
    respond_with Task.all
  end

  def show
    respond_with @task
  end

  def create
    task = Task.new(task_params)
    if task.save
      respond_with task, status: :created, location: api_project_tasks_url
    else
      render json: task.errors, status: 422
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      respond_with @task, status: 200
    else
      render json: @task.errors, status: 422
    end
  end

  def destroy
    @task.destroy
    head 204
  end

  private
  def current_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:project_id, :title, :description, :state, :estimated_time, :time_spent, :deadline)
  end
end