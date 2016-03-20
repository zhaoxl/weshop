class Coupon < ActiveRecord::Base
  belongs_to :coupon_template
  belongs_to :user
  
  
  include AASM

  aasm column: :state do
    state :create, :initial => true
    state :used
    
    event :set_state_used do
      transitions :from => :create, :to => :used
    end
  end
  
  def self.get_avable_coupons(user, product_ids)
    coupons = Coupon.where(user: user, state: "create")
    return [] if coupons.blank?
    
    product_categories = Product.where(id: product_ids)
    template_categories = CouponTemplateProductCategory.where(product_category: product_categories.map(&:product_category_id))
    templates = CouponTemplate.where(id: template_categories.map(&:coupon_template_id))
    coupons = coupons.where(coupon_template: templates)
  end
end
