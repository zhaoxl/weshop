class AddCouponIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :coupon_id, :integer
    add_column :orders, :coupon_fee, :decimal, :precision => 10, :scale => 2, default: 0
  end
end
