class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path
  end
  def after_sign_in_path_for(resource)
    if resource.role == :admin
    	reports_path
    else
    	cases_path
    end
  end
end
