class WechatController < ApplicationController
  def login
    redirect_to "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{Settings.wechat.client_id}&redirect_uri=#{Settings.base}/wechat/&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"
  end
end
