class ShippinAddressController < ApplicationController
  def index
    @addresses = current_user.shippin_address
  end
  
  def new
    @address = ShippinAddress.new
    @address.default = !current_user.shippin_address.exists?
  end
  
  def edit
    @address = ShippinAddress.find(params[:id])
  end
  
  def create
    @address = ShippinAddress.new(post_params)
    begin
      @address.user = current_user
      ActiveRecord::Base.transaction do
        if @address.default == true
          ShippinAddress.update_all({default: false})
        end
        @address.save!
      end
    rescue ActiveRecord::RecordInvalid
      flash[:error] = @address.errors.messages.values.flatten[0]
      redirect_to :back and return
    end
    
    redirect_to  shippin_address_index_path
  end
  
  def update
    @address = ShippinAddress.find(params[:id])
    ActiveRecord::Base.transaction do
      if post_params[:default] == "1"
        ShippinAddress.update_all({default: false})
      end
      @address.update_attributes(post_params)
    end
    
    redirect_to  shippin_address_index_path
  end
  
  def destroy
    ShippinAddress.destroy(params[:id])
    
    redirect_to :back
  end
  
  def use
    session[:use_shippin_address_id] = params[:id]
    
    redirect_to params[:goto] || new_order_path
  end
  
  def post_params
    params.require(:shippin_address).permit!
  end
end
