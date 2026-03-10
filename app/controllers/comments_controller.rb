class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: t("alert.comment_create_failure", default: "コメントの投稿に失敗しました")
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
