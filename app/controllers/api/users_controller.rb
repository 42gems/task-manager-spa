class API::UsersController < API::BaseController
  before_action :fetch_user, only: [:projects, :invited_members]
  skip_before_action :authenticate_user, only: [:sign_in, :create]

  def current
    render json: current_user
  end

  def create
    user = User.new(user_params)
    if user.save
      token = user.tokens.create
      render json: { auth_token: token.token }
    else
      render json: user.errors.full_messages, status: :bad_request
    end
  end

  def update
    attrs = params.require(:user).permit(:first_name, :last_name)
    attrs[:image] = converted_image if params[:user][:image] =~ /^data:image\/jpeg;base64/
    current_user.update_attributes(attrs)
    head 200
  end

  def projects
    respond_with @user.projects
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
    def converted_image
      base64_string = params[:user][:image].split('base64,')[1]
      CarrierStringIO.new(Base64.decode64(base64_string))
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end

    def fetch_user
      @user = User.find(params[:id])
    end
end