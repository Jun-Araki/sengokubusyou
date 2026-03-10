class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show ranks prefecture top info]
  before_action :set_post, only: %i[edit update destroy]

  def index
    result = Post.index_bundle(params, current_user)
    @q = result[:q]
    @posts_match = result[:posts_match]
    @posts = result[:posts]
  end

  def show
    @post = Post.find_by(id: params[:id])
    unless @post
      render_not_exists
      return
    end

    @post_prefecture = Post.prefectures.fetch(@post.prefecture)
    @comments = @post.comments.includes(:user)
    @comment = current_user.comments.new if user_signed_in?
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: t("notice.post_create")
    else
      flash.now[:alert] = t("alert.post_create_failure")
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t("notice.post_update")
    else
      flash.now[:alert] = t("notice.post_update_failure")
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, alert: t("alert.post_delete")
  end

  def prefecture
    return if params[:prefecture].blank?

    result = Post.prefecture_bundle(params, current_user)
    @posts_select = result[:posts_select]
    @posts = result[:posts]
    @post_display = result[:post_display]
  end

  def ranks
    result = Post.rankings_bundle(current_user)
    @likes = result[:likes]
    @comments = result[:comments]
  end

  def top
    @likes = Post.top_likes
  end

  def info; end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :kana, :initial, :prefecture, :commentary, :image)
  end
end
