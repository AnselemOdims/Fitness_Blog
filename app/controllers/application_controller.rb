class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery prepend: true
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name photo bio])
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end
end
