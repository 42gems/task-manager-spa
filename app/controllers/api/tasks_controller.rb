class API::TasksController < API::BaseController
  belongs_to :project,  class_name: "Project"

  private
    def task_params
      params.require(:task).permit(:title, :description, :state, :estimated_time, :time_spent, :deadline)
    end
end