class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
    respond_to :html, :js
  # GET /groups
  # GET /groups.json
  def index
    if(current_user)
      @groups = Group.all
    else
      redirect_to "/users/sign_in"
    end    
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    if(current_user)
    @group = Group.find(params[:id])
    @friends = Friend.all
    @users = User.all
    @users_friends_id=[]
    @users_friends_email=[]
    for friend in @friends
      if (current_user.id==friend.user_id)&&(friend.group_id==@group.id)
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
    else
      redirect_to "/users/sign_in"
    end 
  end
  

  # GET /groups/new
  def new
    if (current_user)
      @group = Group.new
    else
      redirect_to "/users/sign_in"
    end 
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    if(current_user)
    @group = Group.new(group_params)
    @group['user_id']=current_user.id
    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
    else
      redirect_to "/users/sign_in"
    end 
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    if (current_user)
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
    else
      redirect_to "/users/sign_in"
    end 
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    if (current_user)
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
    else
      redirect_to "/users/sign_in"
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:group, :user_id)
    end
end
