# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include UsersHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action  :store_location

  def store_location
    if request.fullpath != new_user_registration_path &&
       request.fullpath != new_user_session_path &&
       request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
       !request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    if session[:previous_url] == root_path
      super
    else
      session[:previous_url] || root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname profile twitter user_image])
  end

  private

  def logged_in_user
    unless user_signed_in?# rubocop:disable all
      flash[:danger] = "ログインしてください"# rubocop:disable all
      redirect_to login_url
    end
  end

  def store_current_location
    store_location_for(:user, request.url)
  end
end
