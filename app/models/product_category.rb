require 'carrierwave/orm/activerecord'
class ProductCategory < ActiveRecord::Base
  acts_as_nested_set order_column: :position, dependent: :优惠
  acts_as_list :scope => :parent_id
  default_scope { order('position') }
  
  has_many  :products
  
  mount_uploader :logo, ProductCategoryLogoUploader
  
  def can_delete?
    true
  end
end
