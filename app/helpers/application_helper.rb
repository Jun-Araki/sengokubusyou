module ApplicationHelper
  # # 渡されたユーザーでログインする
  # def log_in(user)
  #   session[:user_id] = user.id
  # end

  # # ユーザーのセッションを永続的にする
  # def remember(user)
  #   user.remember
  #   cookies.permanent.encrypted[:user_id] = user.id
  #   cookies.permanent[:remember_token] = user.remember_token
  # end

  # # # 記憶トークンcookieに対応するユーザーを返す
  # # def current_user
  # #   if (user_id = session[:user_id])
  # #     @current_user ||= User.find_by(id: user_id)
  # #   elsif (user_id = cookies.encrypted[:user_id])
  # #     user = User.find_by(id: user_id)
  # #     if user&.authenticated?(:remember, cookies[:remember_token])
  # #       log_in user
  # #       @current_user = user
  # #     end
  # #   end
  # # end

  # # 渡されたユーザーがカレントユーザーであればtrueを返す
  # def current_user?(user)
  #   user && user == current_user
  # end

  # # ユーザーがログインしていればtrue、その他ならfalseを返す
  # def logged_in?
  #   !current_user.nil?
  # end

  # # アクセスしようとしたURLを覚えておく
  # def store_location
  #   session[:forwarding_url] = request.original_url if request.get?
  # end
end
