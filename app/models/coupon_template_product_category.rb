class CouponTemplateProductCategory < ActiveRecord::Base
  belongs_to  :product_category
  belongs_to  :coupon_template
end
