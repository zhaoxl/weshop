class OrdersController < AppBaseController
  def new
    unless @shippin_address = current_user.shippin_address.where(id: session[:use_shippin_address_id]).first
      unless @shippin_address = current_user.shippin_address.where(default: true).first
        @shippin_address = current_user.shippin_address.first
      end
    end
    
    if current_user.carts.blank?
      render 'empty', layout: 'application_new'
    else
      render layout: 'application_new'
    end
  end
  
  def create
    cart_ids = params[:cart_ids]
    address_id = params[:address_id]
    remark = params[:remark]
    coupon_id = params[:coupon_id]
    redirect_to :back, notice: '请选择商品' and return if cart_ids.blank?
    
    order = Order.generate(current_user, cart_ids, address_id, remark, coupon_id)
    
    redirect_to member_order_path(order)
  end
  
  def calculate_coupon
    coupon = Coupon.where(user: current_user, state: "create", id: params[:coupon_id]).first
    price = current_user.carts.to_a.sum{|cart| 
  		cart.total * cart.product.try(:price)||0
  	}.to_f - coupon.try(:price).to_f
    
    price = 0 if price < 0
  	render text: price
  end
  

  def post_params
    params.require(:order).permit!
  end
end
