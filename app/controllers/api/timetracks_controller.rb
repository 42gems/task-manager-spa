class API::TimetracksController < API::BaseController

  def index
    respond_with current_user.timetracks.where(task_id: params[:task_id])
  end

  def create
    timetrack = Timetrack.new(timetrack_params)

    if timetrack.save
      head 201
    else
      respond_with timetrack.errors
    end
  end

  def update
    timetrack = Timetrack.find(params[:id])
    if timetrack.update_attributes(timetrack_params)
      respond_with timetrack
    else
      respond_with timetrack.errors
    end
  end

  def destroy
    timetrack = Timetrack.find(params[:id])
    timetrack.destroy
    head 204
  end

  private
  def timetrack_params
    params.require(:timetrack).permit(:user_id, :task_id, :amount, :start_date,
                                      comments_attributes: [
                                        :user_id, :timetrack_id, :id, :body ])
  end
end
