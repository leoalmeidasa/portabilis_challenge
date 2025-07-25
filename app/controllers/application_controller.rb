class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Parameters allowed when signing up user
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email, :password, :password_confirmation, :role ])
  end

  def ransack_params
    params.fetch(:q, {})
  end

  private

  def user_not_authorized
    render json: { error: 'Not authorized' }, status: :forbidden
  end
end
