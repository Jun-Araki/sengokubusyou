class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :set_user

  def show
    @posts = @user.posts
  end

  def following
    @title = "フォロー"
    @users = @user.following
    render "show_follow"
  end

  def followers
    @title = "フォロワー"
    @users = @user.followers
    render "show_follow"
  end

  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
