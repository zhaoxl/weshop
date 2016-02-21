class Product < ActiveRecord::Base
  acts_as_list
  
  belongs_to  :product_category
  has_many  :product_logos
  has_many  :order_products
  has_many  :orders
  
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
    (self.product_logos.first || ProductLogo.find(4)).logo
  end
  
  
end
