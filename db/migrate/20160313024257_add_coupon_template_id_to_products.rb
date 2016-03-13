class AddCouponTemplateIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :coupon_template_id, :integer
  end
end
