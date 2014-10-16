class API::BaseController < ApplicationController
  include API::AuthLogic
  respond_to :json
end
