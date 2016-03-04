class IndexController < ApplicationController
  def index
    if params[:recommend].present? && current_user.recommend_user_id.blank?
      current_user.update_attribute(:recommend_user_id, params[:recommend])
    end
    
    render text: "请使用微信客户端打开", layout: false and return if current_user.blank?
    
    render layout: 'application_new' unless current_user.blank?
  end
end
