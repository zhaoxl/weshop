class ProductsController < AppBaseController
  layout 'application_new'
  
  def show
    @product = Product.find(params[:id])
    
  end
end
