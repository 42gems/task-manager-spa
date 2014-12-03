class API::TimetracksController < API::BaseController
  before_action :fetch_task, except: [:edit, :show, :destroy]

  def index
    respond_with @task.timetracks
  end

  private
  def timetrack_params
    params.require(:timetrack).permit(:user_id, :task_id, :amount, :start_date,
                                      comments_attributes: [
                                        :user_id, :timetrack_id, :id, :body ])
  end

  def fetch_task
    @task = Task.find(params[:task_id])
  end
end
