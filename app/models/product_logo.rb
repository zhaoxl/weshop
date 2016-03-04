class ProductLogo < ActiveRecord::Base
  acts_as_list :scope => :product_id
  
  belongs_to  :product
  
  mount_uploader :logo, ProductLogoUploader
end
