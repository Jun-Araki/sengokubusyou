module Users
  class PasswordsController < Devise::PasswordsController
    before_action :ensure_normal_user, only: :create# rubocop:disable all

    def ensure_normal_user
      return unless params[:user][:email].downcase == "guest@example.com"

      redirect_to new_user_session_path, alert: t("alert.guest_password")
    end
  end
end
