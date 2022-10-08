# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include UsersHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

  private

  def logged_in_user
    unless user_signed_in?# rubocop:disable all
      flash[:danger] = "ログインしてください"# rubocop:disable all
      redirect_to login_url
    end
  end
end
