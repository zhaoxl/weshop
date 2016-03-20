class CreateCouponTemplateProductCategories < ActiveRecord::Migration
  def change
    create_table :coupon_template_product_categories do |t|
      t.references  :product_category
      t.references  :coupon_template
    end
  end
end
