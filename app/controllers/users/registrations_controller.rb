module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :ensure_normal_user, only: %i[update destroy]# rubocop:disable all

    # def update
    #   redirect_to user_path(current_user)
    # end

    def ensure_normal_user
      redirect_to root_path, alert: "ゲストユーザーは更新・削除できません。" if resource.email == "guest@example.com"# rubocop:disable all
    end

    def after_sign_up_path_for(resource)
      user_path(resource)
    end

    def after_update_path_for(resource)
      user_path(resource)
    end
  end
end
