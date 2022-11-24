class PostsController < ApplicationController
  PER_PAGE = 12

  before_action :authenticate_user!, except: %w[index show ranks prefecture top info]
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_ranks, only: %i[ranks top]

  def index
    @q = Post.ransack(params[:q])
    @q_result = @q.result.includes(:user, :likes).order(kana: :asc).page(params[:page]).per(PER_PAGE)

    @posts = if params[:initial].present?
               @q_result.select_initial(params[:initial])
             else
               @q_result
             end
  end

  def show
    if Post.exists?(params[:id])
      @post = Post.find(params[:id])
      @comments = @post.comments
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
    posts = Post.includes(:user, :likes).page(params[:page]).per(PER_PAGE)

    if params[:prefecture].present?
      @posts = posts.select_prefecture(params[:prefecture])
      @post_display = Post.prefectures.invert.transform_keys!(&:to_s).fetch(params[:prefecture])
    else
      @posts = posts
    end
  end

  def ranks; end

  def top; end

  def info; end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_ranks
    @likes    = Post.find(Like.group(:post_id).order("count(post_id) desc").limit(3).pluck(:post_id))
    @comments = Post.find(Comment.group(:post_id).order("count(post_id) desc").limit(3).pluck(:post_id))
  end

  def post_params
    params.require(:post).permit(:name, :kana, :initial, :prefecture, :commentary, :image)
  end
end
