class API::ProjectsController < API::BaseController
  def members
    respond_with current_user.invited
  end

  private
  def project_params
    params.require(:project).permit(:owner_id, :title, :description)
  end
end
