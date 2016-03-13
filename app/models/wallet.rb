class Wallet < ActiveRecord::Base
  class InsufficientBalanceException < Exception
  end
  
  def self.waste(user, payment)
    wallet = Wallet.where(user: user).first
    raise InsufficientBalanceException unless wallet
    wallet.balance -= payment.amount
    raise InsufficientBalanceException if wallet.balance < 0
    wallet.save
  end
  
  
end
