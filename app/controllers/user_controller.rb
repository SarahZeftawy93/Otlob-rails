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

	end
