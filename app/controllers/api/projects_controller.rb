class API::ProjectsController < API::BaseController
  before_action :fetch_user,        only: [:add_member, :send_notification]
  before_action :fetch_project,     except: [:index, :create]
  # TODO move logic to add_member method on the project class.
  after_action  :send_notification, only: :add_member

  def index
    @projects = current_user.all_projects
  end

  def members
    @users = @project.members_with_owner
  end

  def user_rights
    respond_with @project.type_for current_user
  end

  def users_for_invite
    @users = @project.select_users_for_invites params[:search]
  end

  def timeline_matrix
    timeline = Timeline.new(@project, { from: params[:from], to: params[:to] })
    respond_with timeline.matrix
  end

  def add_member
    # TODO move logic to project model. Some method that will return boolean to render 200 or error.
    # also we need some authorization here
    @project.members << @user unless @project.members.include? @user
    head 200
  end

  def remove_member
    # TODO move logic to project model.
    # also we need some authorization here
    @project.members.delete(params[:id])
    head 204
  end

  private
  # TODO move to project add_member action.
  def send_notification
    UserMailer.send_notification(@project, @user)
  end

  def fetch_user
    @user = User.find(params[:id])
  end

  def fetch_project
    # TODO use || operator
    @project = params[:project_id] ? Project.find(params[:project_id]) : Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:owner_id, :title, :description, :private)
  end
end
