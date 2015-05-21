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

	def destroy
	end

	private

		def post_params
			params.require(:post).permit(:title, :content)
		end
end
