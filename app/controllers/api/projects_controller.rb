class API::ProjectsController < API::BaseController
  def index
    respond_with Project.all
  end
end