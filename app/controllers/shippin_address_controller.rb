class ShippinAddressController < ApplicationController
  def index
    @addresses = current_user.shippin_address
  end
  
  def new
    @address = ShippinAddress.new
  end
end
