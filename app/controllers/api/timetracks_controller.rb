class API::TimetracksController < API::BaseController
  before_action :fetch_task, except: [:edit, :show, :destroy]

  def index
    respond_with @task.timetracks
  end

  def create
    timetrack = @task.timetracks.build
    t = params[:timetrack]

    timetrack.start_date = t[:start_date]
    timetrack.amount = t[:amount]
    timetrack.parse_amount!(t[:time]) if t[:time]

    if timetrack.save
      render json: timetrack, status: 201
    else
      render json: timetrack.errors, status: 422
    end
  end

  private
  def timetrack_params
    params.require(:timetrack).permit(:task_id, :amount, :start_date)
  end

  def fetch_task
    @task = Task.find(params[:task_id])
  end
end
