class WechatController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:pay_notify]
  
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
  
  def pay
    Rails.logger.debug("weixin pay begin=======================")
    order = Order.find(params[:id])
    unifiedorder = {
      body:             order.to_s,
      out_trade_no:     order.scode, # prepay order number
      total_fee:        (order.total_fee*100).to_i,          # 注意：单位是分，不是元
      spbill_create_ip: '127.0.0.1',
      notify_url:       'http://jt.fannybay.net/wechat/pay_notify',
      trade_type:       'JSAPI',
      nonce_str:        SecureRandom.uuid.tr('-', ''),
      openid:          current_user.open_id
    }
    Rails.logger.debug("unifiedorder_params: #{unifiedorder}")
    res = WxPay::Service.invoke_unifiedorder(unifiedorder)
    if res.success?
      Rails.logger.debug("set prepay_id: #{res["prepay_id"]}")
      @pay_p = {
        appId: Settings.wechat.appid,
        timeStamp: Time.now.to_i.to_s,
        nonceStr: SecureRandom.hex,
        package: "prepay_id=#{res["prepay_id"]}",
        signType: "MD5"
      }
      @pay_sign = WxPay::Sign.generate(@pay_p)
    else
      Rails.logger.debug("set prepay_id fail: #{res}")
    end
    Rails.logger.debug("weixin pay end=======================")
  end
  
  def pay_notify
    Rails.logger.debug("weixin pay_notify begin=======================")
    result = Hash.from_xml(request.body.read)["xml"]
    Rails.logger.debug("weixin notify: #{result}")
    if WxPay::Sign.verify?(result)
      pay_serial_number = result["out_trade_no"]
      order = Order.find_by(scode: pay_serial_number)
      order.set_state_payment!
      order.pay_logs.new(
        pay_type: "weixin",
        trade_type: result[:trade_type],
        log: result
      )
      order.save
      #TODO:支付成功后，减库存
      Rails.logger.debug("支付成功")
      render xml: {
        return_code: "SUCCESS"
      }.to_xml(root: 'xml', dasherize: false)
    else
      Rails.logger.debug("支付失败")
      render xml: {
        return_code: "SUCCESS",
        return_msg: "签名失败"
      }.to_xml(root: 'xml', dasherize: false)
    end
    Rails.logger.debug("weixin pay_notify end=======================")
  end
  
end
