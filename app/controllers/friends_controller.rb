class FriendsController < ApplicationController
	def create
		@friendship = current_user.friendships.build(friend_id: params[:friend_id], approved: false)
		if @friendship.save
      flash[:notice] = "Friend requested."
      redirect_to :back
    else
      flash[:error] = "Unable to request friendship."
      redirect_to :back
    end
	end

	def update
    @friendship = Friendship.where(friend_id: current_user.id, user_id: params[:user_id]).first
    @friendship.update(approved: true)
    if @friendship.save
    	flash[:notice] = "Confirmed friends!"
    	redirect_to users_path
    else
    	flash[:error] = "Unable to confirm friends."
    	redirect_to users_path
    end
	end

	def destroy
		@friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last # change using 'find_by'?
		@friendship.destroy
		flash[:notice] = "Unfriended."
		redirect_to :back
	end	
end
