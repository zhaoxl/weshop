class Withdraw < ActiveRecord::Base
  belongs_to  :user
  
  
  include AASM

  aasm column: :state do
    state :create, :initial => true
    state :finish
    
    event :set_state_finish do
      transitions :from => :create, :to => :finish
    end
  end
  
end
