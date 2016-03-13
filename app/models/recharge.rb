class Recharge < ActiveRecord::Base
  belongs_to  :user
  has_many    :pay_logs, :as => :resource
  
  include AASM

  aasm column: :state do
    state :cancel
    state :create, :initial => true
    state :payment
    
    event :set_state_cancel do
      transitions :from => :create, :to => :cancel
    end
    
    event :set_state_payment, after: :wallet_recharge do
      transitions :from => :create, :to => :payment
    end
  end
  
  def wallet_recharge
    Wallet.recharge(self.user, self)
  end
  
end
