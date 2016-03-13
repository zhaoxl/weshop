class Distribution < ActiveRecord::Base
    belongs_to  :user
    has_many    :distribution_incomes
    
    include AASM

    代金卷 column: :state do
      state :cancel
      state :create, :initial => true
      state :reject
      state :pass
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
