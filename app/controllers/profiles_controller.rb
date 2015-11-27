class ProfilesController < ApplicationController
    def new # needs to match the file name under the views folder. Need to create a folder for each view, so for this: profiles > new.html.erb
        # form where a user can fill out their own profile
        @user = User.find(params[:user_id]) # find the user that is currently logged in grabbing it form the URL
        @profile = @user.build_profile # We have this method because we established the model associations between users and profiles
    end
    
    def create
        @user = User.find(params[:user_id])
        @profile = @user.build_profile(profile_params) #Passes in form field values
        if @profile.save
            flash[:success] = "Profile Updated!"
            redirect_to user_path(params[:user_id])
        else
            render action: :new # This calls the new method above
        end
    end
    
    private
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
        end
end