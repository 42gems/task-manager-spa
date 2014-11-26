class API::TimetracksController < API::BaseController
  before_action :fetch_task, except: [:edit, :show, :destroy]

  def index
    respond_with @task.timetracks
  end

  def create
    timetrack = @task.timetracks.build(timetrack_params)

    time = params[:timetrack][:time]
    timetrack.parse_amount!(time) if time

    if timetrack.save
      render json: timetrack, status: 201
    else
      render json: timetrack.errors, status: 422
    end
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
