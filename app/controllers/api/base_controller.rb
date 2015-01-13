class API::BaseController < InheritedResources::Base
  include API::AuthLogic

  after_filter :set_csrf_cookie_for_ng

  respond_to :json

  def update
    update! do |success, failure|
      failure.json { render_validation_errors }
    end
  end

  def create
    create! do |success, failure|
      failure.json { render_validation_errors }
    end
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

    def verified_request?
      super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    end

    def render_validation_errors
      render json: {errors: resource.errors.to_h}, status: 422
    end
end