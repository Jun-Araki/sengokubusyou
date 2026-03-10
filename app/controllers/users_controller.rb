class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :set_user, only: %i[show likes comments following followers]

  PER_PAGE = 12

  def index
    render_not_exists
  end

  def show
    unless @user
      render_not_exists
      return
    end

    @user_posts = @user.posts
    @posts = build_posts(@user.posts)
  end

  def likes
    liked_post_ids = @user.likes.pluck(:post_id)
    @user_posts = Post.where(id: liked_post_ids)
    @posts = build_posts(@user_posts)
  end

  def comments
    commented_post_ids = @user.comments.distinct.pluck(:post_id)
    @user_posts = Post.where(id: commented_post_ids)
    @posts = build_posts(@user_posts)
  end

  def following
    @users = @user.following.includes(:passive_relationships)
  end

  def followers
    @users = @user.followers.includes(:passive_relationships)
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def build_posts(scope)
    scope.includes(:user).with_like_flag(current_user).page(params[:page]).per(PER_PAGE)
  end
end
