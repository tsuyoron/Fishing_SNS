class Public::PostCommentsController < ApplicationController
  def create
    catch = Catch.find(params[:catch_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.catch_id = catch.id
    comment.save
    redirect_to catch_path(catch)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to catch_path(params[:catch_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
