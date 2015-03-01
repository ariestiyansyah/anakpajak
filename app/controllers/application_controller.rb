class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  # layout :layout_by_resource

  
  # def layout_by_resource
  #   if devise_controller? && params[:action]!="edit"
  #     "users"
  #   else
  #     "application"
  #   end
  # end

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  protected
    
    def authenticate_user!(opts={})
      unless user_signed_in?
        @user = User.new
        # render "home/login"
        # render "home/index"
        # if Rails.env.development?
          render "home/login"
        # else
          # render "home/landing" 
        # end
        # render "message/confirmation"
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :description) }
    end
  
end
