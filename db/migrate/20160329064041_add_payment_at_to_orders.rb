class AddPaymentAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_at, :datetime
    add_column :orders, :sent_at, :datetime
    add_column :orders, :receive_at, :datetime
  end
end
