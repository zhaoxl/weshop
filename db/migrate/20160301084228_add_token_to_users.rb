class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :open_id, :string
    add_column :users, :token, :string, limit: 500
    add_column :users, :headimgurl, :string, limit: 1000
  end
end
