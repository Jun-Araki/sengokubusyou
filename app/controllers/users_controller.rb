class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :set_user

  PER_PAGE = 24

  def show
    return if @user.twitter.blank?

    twitter_url = "https://twitter.com/"
    @twitter = twitter_url + @user.twitter
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

  def regists
    @title = "登録"
    @posts = @user.posts.page(params[:page]).per(PER_PAGE)
  end

  def likes
    @title = "いいね"
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @posts = Kaminari.paginate_array(Post.find(likes)).page(params[:page]).per(PER_PAGE)
  end

  def comments
    @title = "コメント"
    comments = Comment.where(user_id: @user.id).pluck(:post_id)
    @posts = Kaminari.paginate_array(Post.find(comments)).page(params[:page]).per(PER_PAGE)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
