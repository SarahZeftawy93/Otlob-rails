class UserController < ApplicationController

	def index
		if(current_user)
			@users = User.all
		else
			redirect_to "/users/sign_in"
		end	
	end

	def show
		@user = User.find(params[:id])

	end

	def sign_out
		# redirect_to users_path
		redirect_to "/users/sign_in"
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to users_path
		end
	end

	private

	def user_params
		params.require(:user).permit(:email)
	end

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20]
                          )
      end
       
    end
  end

	end
