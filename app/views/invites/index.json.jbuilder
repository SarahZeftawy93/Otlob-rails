json.array!(@invites) do |invite|
  json.extract! invite, :id, :is_join, :order_id, :user_id, :status_user
  json.url invite_url(invite, format: :json)
end
