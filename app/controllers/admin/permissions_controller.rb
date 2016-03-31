class Admin::PermissionsController < Admin::BaseController
  def index
    @permissions = Permission.all
  end
  
  def update
    permission = Permission.find(params[:id])
    permission.update_attribute(:name, params[:permission][:name])
    
    redirect_to :back
  end
  
  def refresh
    Permission.refresh
    flash[:success] = "刷新成功!"
    
    redirect_to :back
  end
  
end
