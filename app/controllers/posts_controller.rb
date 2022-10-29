# frozen_string_literal: true

class PostsController < ApplicationController
  PER_PAGE = 24

  before_action :authenticate_user!, except: :index
  before_action :set_post, only: %i[edit update destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:user, :likes).order(furigana_name: :asc).page(params[:page]).per(PER_PAGE)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      redirect_to @post, notice: "武将を登録しました" # rubocop:disable all
    else
      flash.now[:alert] = "武将の登録に失敗しました"
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "武将を更新しました" # rubocop:disable all
    else
      flash.now[:alert] = "武将の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to root_path, alert: "武将を削除しました" # rubocop:disable all
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :furigana_name, :furigana_initial, :prefecture_name, :commentary, :image)
  end
end
