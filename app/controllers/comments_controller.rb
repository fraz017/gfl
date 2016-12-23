class CommentsController < ApplicationController
	def create
    @comment = Comment.new(comment_params)
  	@comment.save
  end

  def update
    @comment = Comment.find(params[:id])
  	@comment.update(comment_params)
  end

  def destroy
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  end

  private

  def comment_params
  	params.require(:comment).permit(:user_id, :case_id, :message)
  end
end
