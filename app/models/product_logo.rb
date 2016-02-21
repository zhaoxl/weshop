class ProductLogo < ActiveRecord::Base
  belongs_to  :product
  
  mount_uploader :logo, ProductLogoUploader
end
