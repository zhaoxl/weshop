class OrderProduct < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :order
  belongs_to  :product
  
  # delegate :logo, to: :product
#   delegate :name, to: :product
  
  
  mount_uploader :logo, ProductLogoUploader
end
