require 'carrierwave/orm/activerecord'
class ProductCategory < ActiveRecord::Base
  acts_as_nested_set
  acts_as_list
  
  has_many  :product
  
  mount_uploader :logo, ProductCategoryLogoUploader
end
