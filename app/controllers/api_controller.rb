class ApiController < ApplicationController
  before_action :authenticate_user

  private
  def authenticate_user
    user_token = request.headers['X-USER-TOKEN']
    if user_token
      @user = User.find_by_token(user_token)
      #Unauthorize if a user object is not returned
      if @user.nil?
        not_authorized
      end
    else
      not_authorized
    end
  end

  def not_authorized
    self.status = :unauthorized
    self.response_body = { error: 'Access denied' }.to_json
    return false
  end
end