class Member::DistributionsController < ApplicationController
  def index
    @distribution = current_user.build_distribution
    redirect_to new_member_distribution_path and return if @distribution.blank?
  end
  
  def new
    @distribution = current_user.build_distribution
  end
  
  def create
    distribution = Distribution.new(post_params)
    distribution.save
    
    redirect_to member_distributions_path, notice: '提交成功，请耐心等待审核结果'
  end
  
  private
  
  def post_params
    params.require(:distribution).permit!
  end
end
