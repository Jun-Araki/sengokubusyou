class UsersController < ApplicationController
  before_action :logged_in_user

  def show
    # @posts = current_user.posts
    @user = User.find(params[:id])
    @posts = @user.posts
    # binding.pry
  end

  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following
    render "show_follow"
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers
    render "show_follow"
  end
end
