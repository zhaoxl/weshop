class Admin::WithdrawsController < Admin::BaseController
  authorize_resource :class => false
  
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @withdraws = Withdraw.all
  end
  
  def edit
    
  end
  
  def update
    begin
      @data.set_state_finish!
      flash[:notice] = '操作成功'
    rescue
      flash[:notice] = '操作失败'
    end
    redirect_to admin_withdraws_path
  end
  
  
  private
  def find_data
    @data = Withdraw.find(params[:id])
  end
  
  def post_params
    params.require(:withdraw).permit!
  end
end
