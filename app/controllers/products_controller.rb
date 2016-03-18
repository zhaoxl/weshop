class ProductsController < ApplicationController
  layout 'application_new'
  
  def show
    @product = Product.find(params[:id])
    
  end
end
