class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create!(post_params)
    redirect_to post_path(post)
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def post_params
    params.require(:post).permit(:name, :catch_copy, :birthplace, :castle, :famous_battle, :recommend_point)
  end
end
