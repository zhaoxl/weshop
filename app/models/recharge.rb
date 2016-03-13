class Recharge < ActiveRecord::Base
  belongs_to  :user
  
  include AASM

  aasm column: :state do
    state :cancel
    state :create, :initial => true
    state :payment
    
    event :set_state_cancel do
      transitions :from => :create, :to => :cancel
    end
    
    event :set_state_payment, after: :gen_coupon do
      transitions :from => :create, :to => :payment
    end
  end
  
  
end
