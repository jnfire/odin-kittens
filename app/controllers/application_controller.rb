class ApplicationController < ActionController::API
  private

  def current_user
    header = request.headers['Authorization']
    return if header.blank?

    token = header.split.last
    return if token.blank?

    User.authenticate_by_token(token)
  end

  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
      return
    end
  end
end
