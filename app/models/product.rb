class Product < ActiveRecord::Base
  acts_as_list
  
  belongs_to  :product_category
  has_many  :product_logos
  has_many  :order_products
  has_many  :orders
end
