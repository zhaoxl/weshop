class Order < ActiveRecord::Base
  belongs_to  :user
  has_many    :order_products
  
  include AASM

  aasm column: :state do
    state :cancel
    state :create, :initial => true
    state :payment
    state :sent
    state :receive
    
    event :set_state_cancel do
      transitions :from => :create, :to => :cancel
    end
    
    event :set_state_payment do
      transitions :from => :create, :to => :payment
    end
    
    event :set_state_sent do
      transitions :from => :payment, :to => :sent
    end
    
    event :set_state_receive do
      transitions :from => :sent, :to => :receive
    end
  end
  
  def self.generate(user, cart_ids, address_id, remark)
    carts = Cart.where(id: cart_ids).joins(:product).select("carts.*, products.price").to_a
    address = ShippinAddress.find(address_id)
    total_fee = carts.sum{|cart| cart.total * cart.price}
    today_order_count = Order.where("TO_DAYS(created_at) = TO_DAYS(NOW())").count+1
    today_order_count = "%05d" % today_order_count.to_s
    rand_code = "%05d" % rand(100000).to_s
    scode = "#{Time.now.strftime("%Y%m%d%H%M%S")}#{today_order_count}#{rand_code}"
    
    ActiveRecord::Base.transaction do
      order = user.orders.build(receiver_address: address.to_s, receiver_name: address.name, total_fee: total_fee, receiver_phone: address.phone, scode: scode, remark: remark)
      order.save!
      carts.each do |cart|
        op = order.order_products.build(product_id: cart.product_id, total: cart.total, price: cart.price, amount: cart.total*cart.price)
        op.logo = cart.product.logo.sanitized_file
        op.save!
        #删除购物车中商品
        cart.destroy!
      end
      
    end
  end
  
end
