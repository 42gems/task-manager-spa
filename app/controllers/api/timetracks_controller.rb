class API::TimetracksController < API::BaseController
  before_action :fetch_task, except: [:edit, :show]

  def index
    respond_with current_user.timetracks.where(task_id: @task.id)
  end

  def create
    timetrack = Timetrack.new(timetrack_params)

    if timetrack.save
      # TODO move to timetrack model after create callback
      @task.time_spent += timetrack.amount if timetrack.amount
      @task.save
      head 201
    else
      respond_with timetrack.errors
    end
  end

  def update
    timetrack = Timetrack.find(params[:id])
    # TODO: too much business logic in controller
    old_amount = timetrack.amount

    # TODO: this should look like if timetrack.update_time(timetrack_params)
    # and move this logic to that method
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
    # TODO move to after_destroy callback in the timetrack
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

  # TODO investigate if we really need it at all.
  def fetch_task
    @task = Task.find(params[:task_id])
  end
end
