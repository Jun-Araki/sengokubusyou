class UsersController < ApplicationController
  before_action :logged_in_user
  def show
    @post = Post.new
    @posts = current_user.posts
  end
end
