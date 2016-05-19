class AmountOrdersController < ApplicationController
  before_action :set_amount_order, only: [:show, :edit, :update, :destroy]

  # GET /amount_orders
  # GET /amount_orders.json
  def index
    @amount_orders = AmountOrder.all
  end

  # GET /amount_orders/1
  # GET /amount_orders/1.json
  def show
  end

  # GET /amount_orders/new
  def new
    @amount_order = AmountOrder.new
  end

  # GET /amount_orders/1/edit
  def edit
  end

  # POST /amount_orders
  # POST /amount_orders.json
  def create
    @amount_order = AmountOrder.new(amount_order_params)

    respond_to do |format|
      if @amount_order.save
        format.html { redirect_to @amount_order, notice: 'Amount order was successfully created.' }
        format.json { render :show, status: :created, location: @amount_order }
      else
        format.html { render :new }
        format.json { render json: @amount_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amount_orders/1
  # PATCH/PUT /amount_orders/1.json
  def update
    respond_to do |format|
      if @amount_order.update(amount_order_params)
        format.html { redirect_to @amount_order, notice: 'Amount order was successfully updated.' }
        format.json { render :show, status: :ok, location: @amount_order }
      else
        format.html { render :edit }
        format.json { render json: @amount_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amount_orders/1
  # DELETE /amount_orders/1.json
  def destroy
    @amount_order.destroy
    respond_to do |format|
      format.html { redirect_to amount_orders_url, notice: 'Amount order was successfully destroyed.' }
      format.json { head :no_content }
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
