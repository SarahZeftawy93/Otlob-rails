class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :invites, :join, :is_joined
  end
end
