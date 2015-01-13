class API::InvitesController < API::BaseController
  def index
    @invites = current_user.pending_invites
  end

  def pending_invites
    respond_with current_user.pending_invites.count
  end

  private
  def invite_params
    params.require(:invite).permit(:user_id, :project_id, :accepted)
  end
end
