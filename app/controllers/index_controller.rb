class IndexController < ApplicationController
  layout 'application_new'
  
  def index
    if params[:recommend].present? && current_user.recommend_user_id.blank?
      current_user.update_attribute(:recommend_user_id, params[:recommend])
    end
    current_user
  end
  
  def about
    
  end
end
