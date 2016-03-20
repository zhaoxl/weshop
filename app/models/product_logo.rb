class ProductLogo < ActiveRecord::Base
  acts_as_list :scope => :product_id
  
  belongs_to  :product
  
  mount_uploader :logo, ProductLogoUploader
  
  before_destroy  :check_default_logo
  
  def check_default_logo
    return false if self.id == 4
  end
end
