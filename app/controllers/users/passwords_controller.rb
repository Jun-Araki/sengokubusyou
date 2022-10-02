module Users
  class PasswordsController < Devise::PasswordsController
    before_action :ensure_normal_user, only: :create# rubocop:disable all

    def ensure_normal_user
      if params[:user][:email].downcase == "guest@example.com"# rubocop:disable all
        redirect_to new_user_session_path, alert: "ゲストユーザーのパスワード再設定はできません。"# rubocop:disable all
      end
    end
  end
end
