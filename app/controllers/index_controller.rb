class IndexController < ApplicationController
  def index
    if params[:recommend].present? && current_user.recommend_user_id.blank?
      current_user.update_attribute(:recommend_user_id, params[:recommend])
    end
  end
end
