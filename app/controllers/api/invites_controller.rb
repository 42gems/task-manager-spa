class API::InvitesController < API::BaseController
  def index
    respond_with current_user.pending_invites
  end

  private
  def invite_params
    params.require(:invite).permit(:user_id, :project_id, :accepted)
  end
end
