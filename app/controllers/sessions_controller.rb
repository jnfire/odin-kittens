class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = user.generate_auth_token!
      render json: { token: token }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    authenticate_user!

    current_user.clear_auth_token!
    head :no_content
  end
end
