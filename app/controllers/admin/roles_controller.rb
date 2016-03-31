class Admin::RolesController < ShopBaseController
  def index
    @roles = Role.all
  end
  
  def edit
    @role = Role.find(params[:id])
    @role_permissions = @role.permissions.map(&:id)
  end
  
  def update
    @role = Role.find(params[:id])
    @role.update_attribute(:name, params[:role][:name])

    was_ids = @role.permissions.map(&:id)
    per_ids = params[:per_ids].to_a.map(&:to_i)
    @role.permissions.delete(Permission.where(id: was_ids-per_ids))
    @role.permissions << Permission.where(id: per_ids-was_ids)
    
    flash[:notice] = "修改成功"
    redirect_to :back
  end
  
  
end
