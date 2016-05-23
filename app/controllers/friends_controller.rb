class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  # GET /friends
  # GET /friends.json
  def index
    if (current_user)
    @friends = Friend.all
    @users = User.all
    @users_friends_id=[]
    @users_friends_email=[]

    for friend in @friends
      if (current_user.id==friend.user_id)&&(friend.group_id==nil)
          for user in @users
            if user.id == friend.friend_id
              # @users_friends_email << friend
              # @users_friends_email << user.email  
               @users_friends_id << friend
              @users_friends_email << user  #user contain all data of users friends
            end
          end
       end 
    end 
    # @users_friends_email = @users_friends_email.uniq 
    # @users_friends_id = @users_friends_id.uniq 
    else
      redirect_to "/users/sign_in"
    end 
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    @friend = Friend.find(params[:id])
  end

  # GET /friends/new
  def new
    if (current_user)
      @friend = Friend.new
    else
      redirect_to "/users/sign_in"
    end 
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  # POST /friends.json
  def create
    if (current_user)
    @friend = Friend.new(friend_params)
    @friend.group_id=params[:group_id]
    # # @friend['email']
    # # @user = User.select("id").where('users.email'=>@friend.email)
    # abort
    @users = User.all
    @friends = Friend.all
    flag=0
    # falsgflage=0
    addgroup=0
    duplicatefriend=0
    duplicategroup=0
    for user in @users do
      if user.email == @friend.email
          flag=1
          for fuser in @friends do
              if (current_user.id==fuser.user_id)&&(user.id==fuser.friend_id)&&(fuser.group_id==nil)
                duplicatefriend=1
              end
          end  
              if params[:group_id]==nil  
                if duplicatefriend==0
                    @friend['user_id']=current_user.id
                    @friend['friend_id']=user.id
                    @friend['email']=nil
                    @friend.group_id=nil
                    respond_to do |format|
                        if @friend.save
                          format.html { redirect_to friends_path, notice: 'Friend was successfully created.' }
                          format.json { render :show, status: :created, location: @friend }
                        else
                          format.html { render :new }
                          format.json { render json: @friend.errors, status: :unprocessable_entity }
                         end
                    end     
                else
                  # if params[:group_id]==nil
                    respond_to do |format|
                      format.html { redirect_to friends_path,notice: 'This Friend aready exists ^_^'}
                      format.json { render json: @friend.errors, status: :unprocessable_entity }
                    end     
                end   
              else
                @friend.group_id=params[:group_id]
                  for fuser in @friends do
                    if (current_user.id==fuser.user_id)&&(user.id==fuser.friend_id)&&(fuser.group_id==@friend.group_id)
                      duplicategroup=1
                    end
                  end

                  for fuser in @friends do
                    if (current_user.id==fuser.user_id)&&(user.id==fuser.friend_id)
                        addgroup=1
                    end
                  end

                  
                  if duplicategroup==0
                        if addgroup==1
                            @friend['user_id']=current_user.id
                            @friend['friend_id']=user.id
                            @friend['email']=nil
                            @friend.group_id=@friend.group_id
                            respond_to do |format|
                                if @friend.save
                                  format.html { redirect_to group_path(@friend.group_id), notice: 'Friend was successfully created.' }
                                  format.json { render :show, status: :created, location: @friend }
                                else
                                  format.html { render :new }
                                  format.json { render json: @friend.errors, status: :unprocessable_entity }
                                end
                            end 
                        else
                            respond_to do |format|
                              format.html { redirect_to group_path(@friend.group_id), notice: 'Sorry,This Email Not found in Friends ??? ' }
                              format.json { render :show, status: :created, location: @friend }
                            end    
                        end   
                  else
                        respond_to do |format|
                            format.html { redirect_to group_path(@friend.group_id), notice: 'This Friend already exist in This Group ^_^' }
                            format.json { render :show, status: :created, location: @friend }
                        end  
                    end     
                end  
            end 
       
    end   #end for loop to make search about email friend 
    if flag==0
        if params[:group_id]==nil
            respond_to do |format|
              format.html { redirect_to friends_path,notice: 'Sorry, Email Friend Not found ???'}
              format.json { render json: @friend.errors, status: :unprocessable_entity }
            end 
        else
            @friend.group_id=params[:group_id]
           respond_to do |format|
            format.html { redirect_to group_path(@friend.group_id),notice: 'Sorry, Email Friend Not found in Your Friends ???'}
            format.json { render json: @friend.errors, status: :unprocessable_entity }
          end    
        end
    end  
    else
      redirect_to "/users/sign_in"
    end     
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: 'Friend was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    if (current_user)
      if @friend.group_id==nil
          # @friend.group_id=params[:group_id]
          # @friend.destroy
          Friend.where(user_id:@friend.user_id,friend_id:@friend.friend_id).destroy_all
          respond_to do |format|
            format.html { redirect_to friends_url, notice: 'Friend was successfully destroyed.' }
            format.json { head :no_content }
          end
      else
          group_id=@friend.group_id
          @friend.destroy
          respond_to do |format|
            format.html { redirect_to group_path(group_id), notice: 'Friend was successfully destroyed from Group.' }
            format.json { head :no_content }
          end
      end
    else
      redirect_to "/users/sign_in"
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.require(:friend).permit(:email, :friend_id, :group_id, :user_id)
    end
end
