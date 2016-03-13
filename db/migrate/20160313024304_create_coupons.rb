class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.references  :user
      t.references  :coupon_template
      t.string  :state
      t.string  :name
      t.decimal :price, :precision => 10, :scale => 2, default: 0
      t.timestamps
    end
  end
end
