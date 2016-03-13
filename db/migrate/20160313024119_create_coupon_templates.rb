class CreateCouponTemplates < ActiveRecord::Migration
  def change
    create_table :coupon_templates do |t|
      t.string  :name
      t.decimal :price, :precision => 10, :scale => 2, default: 0
    end
  end
end
