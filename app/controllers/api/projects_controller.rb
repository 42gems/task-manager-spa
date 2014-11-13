class API::ProjectsController < API::BaseController
  before_action :fetch_project, only: [:members, :send_invite, :add_member, :remove_member, :users_for_invite]
  skip_before_action :authenticate_user, only: :add_member

  def index
    respond_with current_user.all_projects
  end

  def members
    respond_with @project.members.accepted_invite
  end

  def users_for_invite
    respond_with @project.select_users_for_invites
  end

  def send_invite
    #TODO simplify, and move mailing to callback
    user = User.find(params[:id])
    @project.members << User.find(params[:id])
    UserMailer.send_notification(@project, user)
    head 200
  end

  def remove_member
    @project.members.delete(params[:id])
    head 204
  end

  private
  def fetch_project
    #TODO nil || "lol" wil result "lol"
    if params[:project_id]
      @project = Project.find params[:project_id]
    else
      @project = Project.find params[:id]
    end
  end

  def project_params
    params.require(:project).permit(:owner_id, :title, :description, :private)
  end
end
