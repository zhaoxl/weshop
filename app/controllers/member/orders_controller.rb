class Member::OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order('created_at DESC')
    @orders = @orders.where(state: params[:state]) if params[:state].present?
  end
  
  def set_state
    begin
      order = Order.find(params[:id])
      order.send("set_state_#{params[:state]}!")
    rescue AASM::InvalidTransition
    end
    redirect_to :back
  end
  
  def delete
    order = Order.find(params[:id])
    order.destroy if order.cancel?
    
    redirect_to :back
  end
end
