class UsersController < ApplicationController
  before_action :logged_in_user

  def show
    # binding.pry
    @posts = current_user.posts
  end
end
