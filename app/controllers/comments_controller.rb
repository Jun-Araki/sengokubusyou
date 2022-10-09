class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    # rubocop:disable all
    if @comment.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
    # rubocop:enable all
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
