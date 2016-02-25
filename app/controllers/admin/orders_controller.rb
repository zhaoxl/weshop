class Admin::OrdersController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @orders = Order.where("")
    @orders = @orders.where(state: params[:state]) if params[:state].present?
    @orders = @orders.page(params[:page]).per(100)
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    flash[:success] = "编辑成功"
    
    redirect_to :back 
  end
  
  def sent
    
  end
  
  def sent_save
    @data.set_state_sent!
    @data.update_attributes(post_params)
    flash[:success] = "发货成功"
    
    redirect_to admin_orders_path
  end
  
  private
  def find_data
    @data = Order.find(params[:id])
  end
  
  def post_params
    params.require(:order).permit!
  end
  
  
  
end
 