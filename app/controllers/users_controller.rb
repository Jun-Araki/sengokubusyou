class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :set_user, except: :show
  before_action :set_likes, only: %i[likes comments]

  PER_PAGE = 12

  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      @user_posts = @user.posts
      @posts = @user.posts.includes(:user).add_is_liked(current_user).page(params[:page]).per(PER_PAGE)
    else
      render "not_exists"
    end
  end

  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @user_posts = Post.find(likes)

    user_likes = @likes.find(likes)
    @posts = Kaminari.paginate_array(user_likes).page(params[:page]).per(PER_PAGE)
  end

  def comments
    comments = Comment.where(user_id: @user.id).pluck(:post_id)
    @user_posts = Post.find(comments)

    user_comments = @likes.find(comments)
    @posts = Kaminari.paginate_array(user_comments).page(params[:page]).per(PER_PAGE)
  end

  def following
    @users = @user.following.includes(:active_relationships)
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_likes
    @likes = Post.includes(:user).add_is_liked(current_user)
  end
end
