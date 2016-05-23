class AmountOrdersController < ApplicationController
  before_action :set_amount_order, only: [:show, :edit, :update, :destroy]

  # GET /amount_orders
  # GET /amount_orders.json
  def index
    if (current_user)
      @amount_orders = AmountOrder.all
    else
      redirect_to "/users/sign_in"
    end
  end

  def joined
    @joins = Invite.where(:is_joined => 1) 
  end
  
  def show
  end

  def new
    if (current_user)
      @amount_order = AmountOrder.new
    else
      redirect_to "/users/sign_in"
    end
  end

  def edit
  end

  def create
    if (current_user)
      @amount_order = AmountOrder.new(amount_order_params)
      @amount_order['user_id'] = current_user.id
      respond_to do |format|
        if @amount_order.save
          format.html { redirect_to amount_orders_path, notice: 'Amount order was successfully created.' }
          format.json { render :index, status: :created, location: @amount_order }
        else
          format.html { render :index }
          format.json { render json: @amount_order.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to "/users/sign_in"
    end  
  end

  def update
    if (current_user)
      respond_to do |format|
        if @amount_order.update(amount_order_params)
          format.html { redirect_to @amount_order, notice: 'Amount order was successfully updated.' }
          format.json { render :show, status: :ok, location: @amount_order }
        else
          format.html { render :edit }
          format.json { render json: @amount_order.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to "/users/sign_in"
    end
  end

  def destroy
    @amount_order.destroy
    respond_to do |format|
      format.html { redirect_to amount_orders_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amount_order
      @amount_order = AmountOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amount_order_params
      params.require(:amount_order).permit(:item, :comment, :amount, :price, :order_id, :user_id)
    end
end
