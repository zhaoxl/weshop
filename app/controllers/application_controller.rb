class ApplicationController < ActionController::Base
  def current_user
    begin
      return User.find(session[:user_id])
    rescue
      redirect_to "/wechat/login"
    end
  end
end
