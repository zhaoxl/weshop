class ShippinAddress < ActiveRecord::Base
  belongs_to  :user
  
  validates :province_code, presence:{message:'请选择省份'}
  validates :city_code, presence:{message:'请选择城市'}
  validates :street_code, presence:{message:'请选择地区'}
  validates :detail, presence:{message:'请输入详细地址'}
  validates :name, presence:{message:'请输入收货人姓名'}
  validates :phone, presence:{message:'请输入收货人手机号'}
  validates :phone,length:{in: 11..11,message:'手机号格式错误'} 
  
  def province
    AreaProvince.where(code: self.province_code).select(:name).first.try(:name)
  end
  
  def city
    AreaCity.where(code: self.city_code).select(:name).first.try(:name)
  end
  
  def street
    AreaStreet.where(code: self.street_code).select(:name).first.try(:name)
  end
  
  def to_s
    "#{province}  #{city}  #{street}  #{detail}"
  end
end
