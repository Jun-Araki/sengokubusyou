class PostsController < ApplicationController
  PER_PAGE = 12

  before_action :authenticate_user!, except: %i[index show ranks prefecture top info]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @q, @posts_match = Post.search_with_initial(params)
    @posts = build_posts(@posts_match, includes: [:user], order: { created_at: :asc })
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

    @posts_select = Post.by_prefecture(params[:prefecture])
    @posts = build_posts(@posts_select, includes: [:likes])
    @post_display = Post.prefecture_label(params[:prefecture])
  end

  def ranks
    posts = Post.includes(:likes).with_like_flag(current_user)
    @likes = posts.find(Post.top_ids_by_likes)
    @comments = posts.find(Post.top_ids_by_comments)
  end

  def top
    @likes = Post.find(Post.top_ids_by_likes)
  end

  def info; end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :kana, :initial, :prefecture, :commentary, :image)
  end

  def build_posts(scope, includes:, order: nil)
    relation = scope.includes(includes).with_like_flag(current_user)
    relation = relation.order(order) if order
    relation.page(params[:page]).per(PER_PAGE)
  end
end
