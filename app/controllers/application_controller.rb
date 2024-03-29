class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do
    flash[:danger] = 'You do not have permission to access this page.'
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = 'Something went Wrong...'
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotDestroyed do
    flash[:notice] = 'Something went Wrong...'
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
