class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    redirect_to request.referer if @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
