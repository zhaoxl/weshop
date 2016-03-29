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
  
  def balance=(val)
    self_wallet = self.wallet||self.build_wallet
    self_wallet.balance = val.to_f
    self_wallet.save
  end
  
  def score
    self.wallet.try(:score).to_i
  end
  
  def score=(val)
    self_wallet = self.wallet||self.build_wallet(balance: 0, score: 0)
    self_wallet.score = val.to_f
    self_wallet.save
  end
  
  #充值卡充值
  def recharge(card)
    ActiveRecord::Base.transaction do
      #修改充值卡状态
      card.user = self
      card.set_state_used!
      #根据设置调整赠送金额
      handsel = 0
      if setting = Setting.where(key: :recharge_card_recharge_handsel).first
        handsel = (card.price * setting.value.to_f) / 100
      end
    
      unless w = self.wallet
        w = self.build_wallet(balance: 0, score: 0)
      end
      w.balance += card.price + handsel
      w.save
    end
  end
  
  #获得分销分红
  def dividend(order)
    self_wallet = self.wallet||self.build_wallet(balance: 0, score: 0)
    amount = order.total_fee*0.15
    self_wallet.balance += amount
    self_wallet.save
    
    DividendLog.create(user: order.user, recommend_user: self, order: order, amount: amount)
  end
end
