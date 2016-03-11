class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many  :orders
  has_many  :carts
  has_many  :shippin_address
  has_one   :distribution
  
  mount_uploader :qrcode, UserQrcodeUploader
  
  def is_distribution?
    self.distribution && !["cancel", "create"].include?(self.distribution.state)
  end
end
