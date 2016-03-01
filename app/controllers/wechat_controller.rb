class WechatController < ApplicationController
  layout false
  
  def login
    redirect_to "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{Settings.wechat.appid}&redirect_uri=#{Settings.base}/wechat/login_get_code_callback&response_type=code&scope=snsapi_userinfo&state=#{params[:recommend].to_i}#wechat_redirect"
  end
  
  def login_get_code_callback
    code = params[:code]
    url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Settings.wechat.appid}&secret=#{Settings.wechat.secret}&code=#{code}&grant_type=authorization_code"
    
    result = JSON.parse(URI.parse(url).read)
    open_id = result["openid"]
    token = result["access_token"]
    
    p "=============================="
    p "open_id:#{open_id}"
    p "token:#{token}"
    
    unless user = User.where(open_id: open_id).first
      #获取用户资料
      url = "https://api.weixin.qq.com/sns/userinfo?access_token=#{token}&openid=#{open_id}&lang=zh_CN"
      result = JSON.parse(URI.parse(url).read)
      nickname = result["nickname"]
      headimgurl = result["headimgurl"]
      
      user = User.new(open_id: open_id, token: token, name: nickname, headimgurl: headimgurl)
      user.save!
    end
    session[:user_id] = user.id
    
    redirect_to "/?recommend=#{params[:state]}"
  end
  
end
