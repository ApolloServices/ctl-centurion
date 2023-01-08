class ApiController < ApplicationController

  protect_from_forgery with: :exception

  before_action :authenticate
  respond_to :json

  def current_user
    authenticate_with_http_token do |token, options|
      User.find_by(authentication_token: token)
    end
  end

  def current_company
    if current_user&.company
      current_user.company
    else
      render json: {success: false, message: 'User or Company not found.', status: 404, content: []}
      return
    end
  end

  def check_company_matching
    @project.company != current_company ? false : true
  end

  def authenticate
    # TODO - Murtaza, remove this after app debugging
    if params[:action] == "create_api_params"
      user = User.first
    else
      user = current_user
    end
    if user.nil?
      render json: {success: false, message: 'Invalid Token.', status: 403, content: []}
      return
    else
      user
    end
  end
end