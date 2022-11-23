class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :set_user

  PER_PAGE = 12

  def show
    @user_posts = @user.posts
    @posts = @user.posts.includes(:likes).page(params[:page]).per(PER_PAGE)
  end

  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @user_posts = Post.find(likes)
    @posts = Kaminari.paginate_array(Post.find(likes)).page(params[:page]).per(PER_PAGE)
  end

  def comments
    comments = Comment.where(user_id: @user.id).pluck(:post_id)
    @user_posts = Post.find(comments)
    @posts = Kaminari.paginate_array(Post.find(comments)).page(params[:page]).per(PER_PAGE)
  end

  def following
    @users = @user.following
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
