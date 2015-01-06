class API::UsersController < API::BaseController
  before_action :fetch_user, only: [:projects, :invited_members]
  skip_before_action :authenticate_user, only: [:sign_in, :create]

  def current
    render json: current_user
  end

  def projects
    respond_with @user.projects
  end

  def invited_members
    respond_with @user.invited_members
  end

  def sign_in
    token = User.authenticate(params[:user][:email], params[:user][:password])
    if token
      render json: { auth_token: token.token }
    else
      render json: { error: 'Wrong credentials' }, status: :bad_request
    end
  end

  def sign_out
    current_token.destroy
    head 204
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def fetch_user
    @user = User.find(params[:id])
  end
end