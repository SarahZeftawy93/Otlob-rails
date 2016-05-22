class UserController < ApplicationController

	def index
		if(current_user)
			@users = User.all
			@currentuser=[]
			for use in @users do
      			if current_user.id == use.id
            		@currentuser << use
    			end
    		end	


			@orders = Order.all
			@friends = Friend.all
			@myorder=[]
			@myidfriends=[]
			@orderfriends=[]
			for order in @orders do
      			if current_user.id == order.user_id
            		@myorder << order
    			end
    		end	
    		@myorder=@myorder.last(3)

    		for friend in @friends do
      			if current_user.id == friend.user_id
            		@myidfriends<< friend.friend_id
    			end
    		end	
    		@myidfriends = @myidfriends.uniq

    		for forder in @orders do
      			for myfiend in @myidfriends do
	      			if forder.user_id == myfiend
	            		@orderfriends<< forder
	    			end
    			end	
    		end	
	@orderfriends=@orderfriends.last(3)

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
