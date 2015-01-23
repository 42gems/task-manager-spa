class API::TimelineController < API::BaseController
  before_action :fetch_project, only: :matrix

  def matrix
    @timeline = Timeline.new(@project)
    respond_with @timeline.matrix
  end

  # TODO style
private

  def fetch_project
    @project = Project.find(params[:project_id])
  end
end
