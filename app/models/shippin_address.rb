class ShippinAddress < ActiveRecord::Base
  belongs_to  :user
  
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
