module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :ensure_normal_user, only: :destroy# rubocop:disable all

    def ensure_normal_user
      redirect_to root_path, alert: "ゲストユーザーは削除できません。" if resource.email == "guest@example.com"# rubocop:disable all
    end
  end
end
