class API::ProjectsController < API::BaseController
  def members
    respond_with current_user.invited
  end

  def send_invite
    project = Project.find(params[:project_id])
    user = User.find(params[:id])
    UserMailer.send_invite(project, user)
    head 200
  end

  def add_member
    project = Project.find(params[:project_id])
    project.members << User.find(params[:id])
    head 200
  end

  def remove_member
    project = Project.find(params[:project_id])
    project.members.delete(params[:id])
    head 204
  end

  private
  def project_params
    params.require(:project).permit(:owner_id, :title, :description)
  end
end
