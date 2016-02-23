class Admin::ProductLogosController < ApplicationController
  before_action :find_product
  
  def index
    @logos = @product.product_logos
  end
  
  private
  def find_product
    @product = Product.find(params[:product_id])
  end
end
