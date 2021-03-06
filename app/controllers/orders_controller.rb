class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    if(current_user)
        @orders = Order.all
        # @friend.group_id=params[:group_id]
        @invites = Invite.all

        # for ckorder in @orders do
        #   for ckinvite in @invites do
        #     # @aa = select * from invites where order_id == ckinvite.order_id
        #     @nums=Invites.where(order_id: ckinvite.order_id).count
        #  end
        # end




    else
      redirect_to "/users/sign_in" 
    end    
  end

  # GET /orders/1
  # GET /orders/1.json
  def show

  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        # find user invited..
        #send notification..

        #dh user_invited: 
        #user_invited = @order.user


        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }

      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json


  def finish
    @order = Order.find(params[:id])
    @order.status=0
    @order.save
    redirect_to '/orders/'
    
  end
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      @invite = Invite.new

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order, :place, :Image, :date, :user_id)
    end
end
