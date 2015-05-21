class ProfilesController < ApplicationController

	def new
		@profile = current_user.build_profile
		# how to make it so that a new profile is created every time a user signs up?
	end

	def create
		@profile = current_user.create_profile(profile_params)
		if @profile.save
			flash[:success] = "Profile created!"
      redirect_to user_path(current_user)
    else
    	flash[:error] = "Something went wrong."
      redirect_to :back
    end
	end

	def edit
		@profile = Profile.find(current_user.profile.id)
	end

	def update
    @profile = Profile.find(current_user.profile.id)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Something went wrong." 
      redirect_to :back
    end
  end

  # security issue in that ANYONE can access edit_profile path for current user
  
  private

  	def profile_params
    	params.require(:profile).permit(:name, :blurb)
 	 end
end
