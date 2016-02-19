require 'carrierwave/orm/activerecord'
class ProductCategory < ActiveRecord::Base
  acts_as_nested_set :order => :position
  acts_as_list :scope => :parent_id
  default_scope { order('parent_id, position') }
  
  has_many  :products
  
  mount_uploader :logo, ProductCategoryLogoUploader
  
  def can_delete?
    true
  end
end
