class API::TimetracksController < API::BaseController
  before_action :fetch_task, except: [:edit, :show]

  def index
    respond_with current_user.timetracks.where(task_id: @task.id)
  end

  def create
    timetrack = Timetrack.new(timetrack_params)

    if timetrack.save
      @task.time_spent += timetrack.amount if timetrack.amount
      @task.save
      head 201
    else
      respond_with timetrack.errors
    end
  end

  def update
    timetrack = Timetrack.find(params[:id])
    old_amount = timetrack.amount

    if timetrack.update_attributes(timetrack_params)
      @task.time_spent += timetrack.amount - old_amount
      @task.save
      respond_with timetrack
    else
      respond_with timetrack.errors
    end
  end

  def destroy
    timetrack = Timetrack.find(params[:id])
    timetrack.destroy
    @task.time_spent -= timetrack.amount if timetrack.amount
    @task.save
    head 204
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
