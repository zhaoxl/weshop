class CouponTemplate < ActiveRecord::Base
  has_many  :coupons
  has_many  :coupon_template_product_categories, dependent: :destroy
  has_many  :product_categories, through: :coupon_template_product_categories
end
