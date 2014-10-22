require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  layout :layout_by_resource

  private

  # Using a custom layout for Devise resources
  def layout_by_resource
    devise_controller? ? "devise_custom" : "application"
  end

end
