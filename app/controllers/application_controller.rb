class ApplicationController < ActionController::Base
  respond_to :json, :html
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_back fallback_location: root_path, notice: exception.message }
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio photo])
  end
end
