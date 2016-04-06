class CartsController < AppBaseController
  
  def add
    unless cart = Cart.where(user: current_user, product_id: params[:product_id]).first
      cart = Cart.new(user: current_user, product_id: params[:product_id])
    end
    cart.total = params[:count].present? ? cart.total+params[:count].to_i : 1
    cart.save
    flash[:success] = "加入购物车成功"
    
    redirect_to :back and return if params[:goto] == "back"
    redirect_to params[:goto] and return if params[:goto].present?
    render text: 'OK'
  end
  
  def remove
    current_user.carts.where(user: current_user, id: params[:id]).delete_all
    
    redirect_to :back and return if params[:goto] == "back"
    redirect_to params[:goto] and return if params[:goto].present?
    render text: 'OK'
  end
  
  def reduce
    if cart = Cart.where(user: current_user, id: params[:id]).first
      if cart.total > 1
        cart.update_attribute(:total, cart.total-1)
      else
        cart.destroy!
      end
    end
    
    redirect_to :back and return if params[:goto] == "back"
    redirect_to params[:goto] and return if params[:goto].present?
    render text: 'OK'
  end
  
  def change
    unless cart = Cart.where(user: current_user, product_id: params[:product_id]).first
      cart = Cart.new(user: current_user, product_id: params[:product_id])
    end
    cart.total = params[:count].to_i
    cart.save
    
    redirect_to :back and return if params[:goto] == "back"
    redirect_to params[:goto] and return if params[:goto].present?
    render text: 'OK'
  end
  
  
end
