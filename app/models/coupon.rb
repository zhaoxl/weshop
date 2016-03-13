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
end
