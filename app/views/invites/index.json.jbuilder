json.array!(@invites) do |invite|
  json.extract! invite, :id, :join, :order_id, :user_id
  json.url invite_url(invite, format: :json)
end
