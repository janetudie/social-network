class UsersController < ApplicationController
	before_action :authenticate_user!

  def index
    @users = User.all
  end

	def show
	  if params[:id] 
      @user = User.find(params[:id])
    else
      @user = current_user
    end

    if @user == current_user && @user.profile.nil?
      redirect_to new_profile_path
    else
      @posts = Post.where(author_id: @user)
      @likes = Like.where(liker_id: @user)
      @comments = Comment.where(author_id: @user)
      @activities = (@posts + @comments + @likes).sort_by(&:created_at).uniq

      @friends = @user.inverse_friends.includes(:profile) + @user.friends.includes(:profile)
    end

    if @user == current_user
      @requests = Friendship.where(friend_id: @user.id, approved: false).includes(:user)
    end

  end

end
