class PostsController < ApplicationController
  PER_PAGE = 12

  before_action :authenticate_user!, except: %w[index show ranks prefecture top info]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @q = Post.ransack(params[:q])

    @posts_match = if params[:initial].present?
                     Post.select_initial(params[:initial])
                   else
                     @q.result
                   end

    @posts = @posts_match.includes(:user).add_is_liked(current_user).order(kana: :asc).page(params[:page]).per(PER_PAGE)
  end

  def show
    if Post.exists?(params[:id])
      @post = Post.find(params[:id])
      @post_prefecture = Post.prefectures.fetch(@post.prefecture)
      @comments = @post.comments.includes(:user, :post)
      @comment = current_user.comments.new if user_signed_in?
    else
      render "not_exists"
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)

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
    flash.now[:alert] = t("alert.post_delete")
    render "not_exists"
  end

  def prefecture
    return if params[:prefecture].blank?

    @posts_select = Post.select_prefecture(params[:prefecture])
    @posts = @posts_select.includes(:likes).add_is_liked(current_user).page(params[:page]).per(PER_PAGE)
    @post_display = Post.prefectures.invert.transform_keys!(&:to_s).fetch(params[:prefecture])
  end

  def ranks
    posts = Post.includes(:likes).add_is_liked(current_user)
    @likes = posts.find(Like.group(:post_id).order("count(post_id) desc").limit(3).pluck(:post_id))
    @comments = posts.find(Comment.group(:post_id).order("count(post_id) desc").limit(3).pluck(:post_id))
  end

  def top
    @likes = Post.find(Like.group(:post_id).order("count(post_id) desc").limit(3).pluck(:post_id))
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
