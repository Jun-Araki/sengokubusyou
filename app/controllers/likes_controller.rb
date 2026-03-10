class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    current_user.likes.create!(post_id: @post.id)
  end

  def destroy
    current_user.likes.find_by!(post_id: @post.id).destroy!
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
