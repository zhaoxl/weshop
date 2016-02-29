class Admin::UsersController < Admin::BaseController
  before_filter :find_data, except: [:index, :new, :create]
    
  def index
    @users = User.where("")
    @users = @users.where(state: params[:state]) if params[:state].present?
    @users = @users.page(params[:page]).per(100)
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    flash[:success] = "编辑成功"
    
    redirect_to :back 
  end
  
  private
  def find_data
    @data = User.find(params[:id])
  end
  
  def post_params
    params.require(:user).permit!
  end
  
  
  
end
 