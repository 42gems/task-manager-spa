class API::InvitesController < API::BaseController
  # TODO add authorization on the creation of invites. As I can see now anyone can invite whoever he wantsto any project.
  def index
    @invites = current_user.pending_invites
  end

  # TODO rename to 'count' as it is actually count, but not invites themselves
  def pending_invites
    respond_with current_user.pending_invites.count
  end

  private
  def invite_params
    params.require(:invite).permit(:user_id, :project_id, :accepted)
  end
end
