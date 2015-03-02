class API::ProjectsController < API::BaseController
  before_action :fetch_user,        only: [:add_member, :send_notification]
  before_action :fetch_project,     except: [:index, :create]
  before_action :check_rights,      only: [:add_member, :remove_member]

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
    @timetracks = @project.timetracks.includes(:user).includes(:task).order created_at: :desc
  end

  def add_member
    @project.add_member(@user)
    head 200
  end

  def remove_member
    @project.delete_member(params[:id])
    head 204
  end

  private
    def fetch_user
      @user = User.find(params[:id])
    end

    def fetch_project
      @project = Project.find(params[:project_id] || params[:id])
    end

    def project_params
      params.require(:project).permit(:owner_id, :title, :description, :private)
    end

    def check_rights
      render json: { error: 'You have no rights' } and return unless @project.owner.id == current_user.id
    end
end
