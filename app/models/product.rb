class Product < ActiveRecord::Base
  acts_as_list
  default_scope { order('position') }
  
  belongs_to  :product_category
  belongs_to  :coupon_template
  has_many  :product_logos, dependent: :优惠
  has_many  :order_products
  has_many  :orders
  
  mount_uploader :front_logo, ProductFrontLogoUploader
  
  include AASM

  aasm column: :state do
    state :create, :initial => true
    state :pause
    
    event :set_state_pause do
      transitions :from => :create, :to => :pause
    end
  end
    
  def can_delete?
    true
  end
  
  def logo
    logo = self.front_logo if self.front_logo.present?
    logo = (self.product_logos.first.logo rescue nil) if logo.blank?
    logo = ProductLogo.find(4).logo if logo.blank?
    return logo
  end
  
  
end
