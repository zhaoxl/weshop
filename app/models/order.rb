class Order < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :coupon
  has_many    :order_products
  has_many    :pay_logs, :as => :resource
  
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
    
    event :set_state_payment, after: :gen_coupon do
      transitions :from => :create, :to => :payment
    end
    
    event :set_state_sent do
      transitions :from => :payment, :to => :sent
    end
    
    event :set_state_receive, after: :receive_callback do
      transitions :from => :sent, :to => :receive
    end
  end
  
  def self.generate(user, cart_ids, address_id, remark, coupon_id=nil)
    order = Order.new
    coupon = Coupon.where(id: coupon_id, user: user, state: "create").first if coupon_id.present?
    carts = Cart.where(id: cart_ids).joins(:product).select("carts.*, products.price, products.name AS product_name").to_a
    address = ShippinAddress.find(address_id)
    total_fee = carts.sum{|cart| cart.total * cart.price}
    ActiveRecord::Base.transaction do
      #如果优惠券可用，则减掉金额，最后金额不可以是负数
      if coupon
        coupon.set_state_used!
        total_fee -= coupon.price
        total_fee = 0 if total_fee < 0
      end
      today_order_count = Order.where("TO_DAYS(created_at) = TO_DAYS(NOW())").count+1
      today_order_count = "%04d" % today_order_count.to_s
      rand_code = "%03d" % rand(1000).to_s
      scode = "#{Time.now.strftime("%y%m%d%H%M%S")}#{today_order_count}#{rand_code}"
      order = user.orders.build(receiver_address: address.to_s, receiver_name: address.name, total_fee: total_fee, receiver_phone: address.phone, scode: scode, remark: remark, coupon_id: coupon.try(:id))
      order.save!
      carts.each do |cart|
        op = order.order_products.build(user: user, product_id: cart.product_id, total: cart.total, price: cart.price, amount: cart.total*cart.price, name: cart.product_name)
        op.logo = cart.product.logo.sanitized_file
        op.save!
        #删除购物车中商品
        cart.destroy!
      end
    end
    return order
  end
  
  def receive_callback
    #自动升级分销
    unless self.user.distribution
      self.user.build_distribution(state: :pass, level: 1).save
    end
    
    #给上家分红
    parent_user = User.find(self.user.recommend_user_id) rescue nil
    if parent_user
      parent_user.dividend(self)
    end
  end
  
  #生成优惠券
  def gen_coupon
    self.order_products.each do |op|
      begin
        product = op.product
        coupon_template = CouponTemplate.find(product.try(:coupon_template_id))
        Coupon.create(user: self.user, coupon_template: coupon_template, name: coupon_template.name, price: coupon_template.price)
      rescue ActiveRecord::RecordNotFound
        next
      end
    end
  end
  
  def to_s
    self.order_products.map{|op| "#{op.name} x #{op.total}"}.join("、")
  end
end
