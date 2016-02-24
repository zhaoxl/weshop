class ProductLogo < ActiveRecord::Base
  acts_as_list
  
  belongs_to  :product
  
  mount_uploader :logo, ProductLogoUploader
end
