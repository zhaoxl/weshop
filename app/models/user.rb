class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many  :orders
  has_many  :carts
  has_many  :shippin_address
  has_one   :distribution
  has_one   :wallet
  
  mount_uploader :qrcode, UserQrcodeUploader
  
  def is_distribution?
    self.distribution && !["cancel", "create"].include?(self.distribution.state)
  end
  
  def balance
    self.wallet.try(:balance).to_f
  end
  
  def score
    self.wallet.try(:score).to_i
  end
  
  def recharge(card)
    unless w = self.wallet
      w = self.build_wallet(balance: 0, score: 0)
    end
    w.balance += card.price
    w.save
  end
  
  #获得分销分红
  def dividend(order)
    wallet ||= self.build_wallet
    amount = order.total_fee*Distribution::DIVIDEND_RATIO[self.distribution.level].to_f
    wallet.balance += amount
    wallet.save
    
    DividendLog.create(user: order.user, recommend_user: self, order: order, amount: amount)
  end
end
