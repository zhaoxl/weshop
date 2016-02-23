class OrdersController < ApplicationController
  def new
    unless @shippin_address = current_user.shippin_address.where(id: session[:use_shippin_address_id]).first
      unless @shippin_address = current_user.shippin_address.where(default: true).first
        @shippin_address = current_user.shippin_address.first
      end
    end
    
  end
  
  def create
    cart_ids = params[:cart_ids]
    address_id = params[:address_id]
    remark = params[:remark]
    redirect_to :back, notice: '请选择商品' and return if cart_ids.blank?
    
    order = Order.generate(current_user, cart_ids, address_id, remark)
    
    redirect_to member_index_index_path
  end
  

  def post_params
    params.require(:order).permit!
  end
end
