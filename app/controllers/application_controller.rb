# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include UsersHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action  :store_location

  def store_location
    if request.fullpath != new_user_registration_path &&
       request.fullpath != new_user_session_path &&
       request.fullpath != users_guest_sign_in_path
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(_resource)
    # if session[:previous_url] == root_path
    #   super
    # else
    session[:previous_url] || root_path
    # end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname profile twitter user_image])
  end

  private

  def logged_in_user
    return if user_signed_in?

    flash[:danger] = t("alert.login")
    redirect_to new_user_session_path
  end

  def store_current_location
    store_location_for(:user, request.url)
  end
end
