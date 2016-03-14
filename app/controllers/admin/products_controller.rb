class Admin::ProductsController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create, :destroy]
    
  def index
    @products = Product.page(params[:page]).per(100)
  end
  
  def new
    @product = Product.new
  end
  
  def create
    product = Product.new(post_params)
    product.save
    flash[:success] = "添加成功"
    
    redirect_to :back 
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    flash[:success] = "编辑成功"
    
    redirect_to :back 
  end

  
  def destroy
    @data.destroy!
    redirect_to :back, notice: '删除成功'
  end
  
  def move_down
    @data.move_lower
    redirect_to :back
  end
  
  def move_up
    @data.move_higher
    redirect_to :back
  end
  
  private
  def find_data
    @data = Product.find(params[:id])
  end
  
  def post_params
    params.require(:product).permit!
  end
  
  
  
end
 