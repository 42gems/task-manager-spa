class API::InvitesController < API::BaseController
  before_action :check_rights, only: [:update]

  def index
    @invites = current_user.pending_invites
  end

  def pending_invites_count
    respond_with current_user.pending_invites.count
  end

  private
    def invite_params
      params.require(:invite).permit(:id, :user_id, :project_id, :accepted)
    end

    def check_rights
      render json: { error: 'You have no rights' } and return unless Invite.find(invite_params[:id]).user_id == current_user.id
    end
end
