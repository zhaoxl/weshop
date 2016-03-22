class Withdraw < ActiveRecord::Base
  belongs_to  :user
  
  
  include AASM

  aasm column: :state do
    state :create, :initial => true
    state :finish
    
    event :set_state_finish, after: :finish_after do
      transitions :from => :create, :to => :finish
    end
  end
  
  def finish_after
    return true unless wallet = Wallet.where(user_id: self.user_id).first
    
    #减少锁定金额
    wallet.lock -= self.amount
    wallet.save
  end
  
end
