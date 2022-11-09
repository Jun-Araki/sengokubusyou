module Users
  class SessionsController < Devise::SessionsController
    def guest_sign_in
      sign_in User.guest
      redirect_to after_sign_in_path_for(resource), notice: t("notice.guest_login")
    end
  end
end
