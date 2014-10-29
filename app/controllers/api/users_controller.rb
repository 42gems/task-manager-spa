class API::UsersController < API::BaseController
  skip_before_action :authenticate_user, only: [:sign_in, :create]

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
end