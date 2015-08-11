class PostsController < ApplicationController

	def index
		@feed = current_user.feed #feed here, including self and friends' posts
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to user_path(current_user)
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "Post updated!"
      redirect_to post_path
    else
      flash.now[:error] = "Post error." 
      render edit_post_path(params[:id])
    end
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
	end

	def destroy
		@post = Post.find(params[:id])
	  if @post.destroy
      flash[:notice] = "Post deleted!"
      redirect_to session.delete(:return_to)
    end	
	end

	private

		def post_params
			params.require(:post).permit(:title, :content)
		end
end
