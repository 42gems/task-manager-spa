class API::ProjectsController < API::BaseController
  before_action :fetch_project,     only: [:members, :timeline_matrix, :add_member, :remove_member, :users_for_invite]
  before_action :fetch_user,        only: [:add_member, :send_notification]
  after_action  :send_notification, only: :add_member

  def index
    respond_with current_user.all_projects
  end

  def members
    respond_with @project.members.accepted_invite
  end

  def users_for_invite
    respond_with @project.select_users_for_invites
  end

  def timeline_matrix
    respond_with @project.timeline_matrix
  end

  def add_member
    @project.members << @user unless @project.members.include? @user
    head 200
  end

  def remove_member
    @project.members.delete(params[:id])
    head 204
  end

  private
  def send_notification
    UserMailer.send_notification(@project, @user)
  end

  def fetch_user
    @user = User.find(params[:id])
  end

  def fetch_project
    @project = params[:project_id] ? Project.find(params[:project_id]) : Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:owner_id, :title, :description, :private)
  end
end
