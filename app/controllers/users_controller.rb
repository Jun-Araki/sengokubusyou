class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :set_user
  before_action :twitter

  PER_PAGE = 24

  def show
    @title = "登録"
    @size = "100"
    @user_posts = @user.posts
    @posts = @user_posts.page(params[:page]).per(PER_PAGE)
  end

  def likes
    @title = "いいね"
    @size = "100"
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @user_posts = Kaminari.paginate_array(Post.find(likes))
    @posts = @user_posts.page(params[:page]).per(PER_PAGE)
    render "show"
  end

  def comments
    @title = "コメント"
    @size = "100"
    comments = Comment.where(user_id: @user.id).pluck(:post_id)
    @user_posts = Kaminari.paginate_array(Post.find(comments))
    @posts = @user_posts.page(params[:page]).per(PER_PAGE)
    render "show"
  end

  def following
    @title = "フォローしているユーザー"
    @users = @user.following
    render "show_follow"
  end

  def followers
    @title = "フォロワー"
    @users = @user.followers
    render "show_follow"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def twitter
    return if @user.twitter.blank?

    twitter_url = "https://twitter.com/"
    @twitter = twitter_url + @user.twitter
  end
end
