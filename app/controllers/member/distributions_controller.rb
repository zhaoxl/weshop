class Member::DistributionsController < Member::BaseController
  def index
    @distribution = current_user.distribution
    redirect_to member_index_index_path and return if @distribution.blank?
  end
  
  def new
    @distribution = current_user.build_distribution
  end
  
  def create
    distribution = Distribution.new(post_params)
    distribution.save
    
    redirect_to member_distributions_path, notice: '提交成功，请耐心等待审核结果'
  end
  
  def qrcode
    render layout: false
  end
  
  def withdraw
    
  end
  
  def withdraw_save
    
  end
  
  private
  
  def post_params
    params.require(:distribution).permit!
  end
end
