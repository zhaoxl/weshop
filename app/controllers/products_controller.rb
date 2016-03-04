class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    
    render layout: 'application_new'
  end
end
