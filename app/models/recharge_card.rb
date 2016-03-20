class RechargeCard < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :recharge_card_category
  
  
  include AASM

  aasm column: :state do
    state :create, :initial => true
    state :used
    
    event :set_state_used do
      transitions :from => :create, :to => :used
    end
  end
  
  
end
