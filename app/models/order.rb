class Order < ActiveRecord::Base
  belongs_to  :user
  has_many    :order_products
  
  include AASM

  aasm column: :state do
    state :create, :initial => true
    state :payment
    state :sent
    
    event :set_state_payment do
      transitions :from => :create, :to => :payment
    end
    
    event :set_state_sent do
      transitions :from => :payment, :to => :sent
    end
  end
  
end
