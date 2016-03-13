class Distribution < ActiveRecord::Base
  DIVIDEND_RATIO = {1 => 0.1}
  belongs_to  :user
  has_many    :distribution_incomes
  
  include AASM

  aasm column: :state do
    state :cancel
    state :create
    state :reject
    state :pass, :initial => true
    state :invalid
  
    event :set_state_cancel do
      transitions :from => :create, :to => :cancel
    end
  
    event :set_state_reject do
      transitions :from => :create, :to => :reject
    end
  
    event :set_state_pass do
      transitions :from => :create, :to => :pass
    end
  
    event :set_state_invalid do
      transitions :from => :pass, :to => :invalid
    end
  end
end
