class AddExpressToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :express, :string
    add_column :orders, :express_number, :string
  end
end
