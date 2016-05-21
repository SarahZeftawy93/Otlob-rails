class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  # GET /friends
  # GET /friends.json
  def index
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
    @users_friends_email = @users_friends_email.uniq 
    # @users_friends_id = @users_friends_id.uniq 
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    @friend = Friend.find(params[:id])
  end

  # def checkmail

  #   email= [params[:email]]
  #   @user = User.find_by email:email
  #   if(@user)
  #       chek=array('ansuser'=>'true');
  #     else
  #       chek=array('ansuser'=>'false');
  #     end
  #   # @user = User.select("id").where('users.email'=>@friend['email'])
  # end 

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(friend_params)
    @friend.group_id=params[:group_id]
    # # @friend['email']
    # # @user = User.select("id").where('users.email'=>@friend['email'])
    # abort
    @users = User.all
    flag=0
    gflag=0
    for user in @users do
      if user.email == @friend.email
            @friend['user_id']=current_user.id
            @friend['friend_id']=user.id
            @friend['email']=nil
            if params[:group_id]==nil
              @friend.group_id=nil
            else
              gflag=1
              @friend.group_id=params[:group_id]
            end  
            flag=1
      end 
    end   #end for loop to make search about email friend 

    if flag==1
        if gflag==1
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
            if @friend.save
              format.html { redirect_to friends_path, notice: 'Friend was successfully created.' }
              format.json { render :show, status: :created, location: @friend }
            else
              format.html { render :new }
              format.json { render json: @friend.errors, status: :unprocessable_entity }
            end
        end

       end 
    else
        respond_to do |format|
        format.html { render :new }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
        end  
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
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: 'Friend was successfully destroyed.' }
      format.json { head :no_content }
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
