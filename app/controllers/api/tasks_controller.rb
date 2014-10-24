class API::TasksController < API::BaseController
  before_action :current_task, only: [:show, :edit, :update, :destroy]

  private
    def task_params
      params.require(:task).permit(:project_id, :title, :description, :state, :estimated_time, :time_spent, :deadline)
    end
end