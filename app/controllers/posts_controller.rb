# frozen_string_literal: true

class PostsController < ApplicationController
  PER_PAGE = 12

  before_action :authenticate_user!, except: %w[index show ranks prefecture]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @q = Post.ransack(params[:q])
    @q_result = @q.result.order(furigana_name: :asc).page(params[:page]).per(PER_PAGE)

    @posts = if params[:furigana_initial].present?
               @q_result.select_furigana_initial(params[:furigana_initial])
             else
               @q_result
             end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new if user_signed_in?
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
    redirect_to root_path, alert: "武将を削除しました" # rubocop:disable all
  end

  def ranks
    @likes    = Post.find(Like.group(:post_id).order("count(post_id) desc").limit(3).pluck(:post_id))
    @comments = Post.find(Comment.group(:post_id).order("count(post_id) desc").limit(3).pluck(:post_id))
  end

  def prefecture
    posts = Post.page(params[:page]).per(PER_PAGE)

    @posts = if params[:prefecture_name].present?
               posts.select_prefecture_name(params[:prefecture_name])
             else
               posts
             end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :furigana_name, :furigana_initial, :prefecture_name, :commentary, :image)
  end
end
