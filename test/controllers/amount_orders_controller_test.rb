require 'test_helper'

class AmountOrdersControllerTest < ActionController::TestCase
  setup do
    @amount_order = amount_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:amount_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create amount_order" do
    assert_difference('AmountOrder.count') do
      post :create, amount_order: { amount: @amount_order.amount, comment: @amount_order.comment, item: @amount_order.item, order_id: @amount_order.order_id, price: @amount_order.price, user_id: @amount_order.user_id }
    end

    assert_redirected_to amount_order_path(assigns(:amount_order))
  end

  test "should show amount_order" do
    get :show, id: @amount_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @amount_order
    assert_response :success
  end

  test "should update amount_order" do
    patch :update, id: @amount_order, amount_order: { amount: @amount_order.amount, comment: @amount_order.comment, item: @amount_order.item, order_id: @amount_order.order_id, price: @amount_order.price, user_id: @amount_order.user_id }
    assert_redirected_to amount_order_path(assigns(:amount_order))
  end

  test "should destroy amount_order" do
    assert_difference('AmountOrder.count', -1) do
      delete :destroy, id: @amount_order
    end

    assert_redirected_to amount_orders_path
  end
end
