module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :ensure_normal_user, only: %i[update destroy]# rubocop:disable all

    def ensure_normal_user
      redirect_to root_path, alert: t("alert.guest_update_delete") if resource.email == "guest@example.com"
    end

    def after_sign_up_path_for(resource)
      user_path(resource)
    end

    def after_update_path_for(resource)
      user_path(resource)
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end
  end
end
