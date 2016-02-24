class CartsController < ApplicationController
  
  def add
    unless cart = Cart.where(user: current_user, product_id: params[:product_id]).first
      cart = Cart.new(user: current_user, product_id: params[:product_id])
    end
    cart.total += (params[:count]||1).to_i
    cart.save
    flash[:success] = "加入购物车成功"
    
    redirect_to :back and return if params[:goto] == "back"
    redirect_to params[:goto] and return if params[:goto].present?
    render text: 'OK'
  end
  
  def remove
    current_user.carts.where(id: params[:id]).delete_all
    
    redirect_to :back and return if params[:goto] == "back"
    redirect_to params[:goto] and return if params[:goto].present?
    render text: 'OK'
  end
end