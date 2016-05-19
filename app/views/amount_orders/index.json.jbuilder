json.array!(@amount_orders) do |amount_order|
  json.extract! amount_order, :id, :item, :comment, :amount, :price, :order_id, :user_id
  json.url amount_order_url(amount_order, format: :json)
end
