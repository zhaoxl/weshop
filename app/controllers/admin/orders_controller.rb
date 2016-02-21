class Admin::OrdersController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @orders = Order.page(params[:page]).per(100)
  end
  
  def new
    @order = Order.new
  end
  
  def create
    order = Order.new(post_params)
    order.save
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
    @data = Order.find(params[:id])
  end
  
  def post_params
    params.require(:order).permit!
  end
  
  
  
end
 