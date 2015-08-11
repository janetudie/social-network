class LikesController < ApplicationController
	def create
		@likeable = find_likeable.find(params[:likeable_id])
		if @likeable.likes.create(liker_id: current_user.id)
      flash[:notice] = "Liked!"
      redirect_to :back
    else
      flash.now[:error] = "Error."
      redirect_to :back
    end
	end

	def destroy
	  @like = Like.where(likeable_id: params[:likeable_id]).where(liker_id: current_user.id).last
    if @like.destroy
    	flash[:notice] = "Unliked."
      redirect_to :back
    end
	end

	private

		def find_likeable
    	params[:likeable_type].capitalize.constantize
  	end
end
