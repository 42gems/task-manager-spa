class API::ProjectsController < API::BaseController
  before_action :fetch_user,        only: [:add_member, :send_notification]
  before_action :fetch_project,     except: [:index, :create]
  after_action  :send_notification, only: :add_member

  def index
    @projects = current_user.all_projects
  end

  def members
    respond_with @project.members.accepted_invite
  end

  def user_rights
    respond_with @project.type_for current_user
  end

  def users_for_invite
    respond_with @project.select_users_for_invites
  end

  def timeline_matrix
    timeline = Timeline.new(@project, { from: params[:from], to: params[:to] })
    respond_with timeline.matrix
  end

  def time_spent
    respond_with @project.time_spent
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
