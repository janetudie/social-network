class CommentsController < ApplicationController
	def new
		@post = Post.find(params[:post_id])
		@comment = Comment.new
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)
		if @comment.save
			flash[:notice] = "Comment created!"
			redirect_to post_path(@post) # how do i redirect to post?
		else
      render new_comment_path
    end
	end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:error] = "Comment deleted."
      redirect_to session.delete(:return_to)
    end
  end


	private

		def comment_params
			params.require(:comment).permit(:content, :post_id, :author_id)
		end
end
