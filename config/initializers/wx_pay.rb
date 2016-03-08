# required
WxPay.appid = Settings.wechat.appid
WxPay.key = Settings.wechat.partnerkey
WxPay.mch_id =  Settings.wechat.mchid.to_s
# pass = Settings.wechat.partnerkey

# cert, see https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=4_3
# using PCKS12
#WxPay.set_apiclient_by_pkcs12(File.read("#{Rails.root}/config/cert/apiclient_cert.p12"), pass)

# optional - configurations for RestClient timeout, etc.
WxPay.extra_rest_client_options = {timeout: 2, open_timeout: 3}




pay_params = {
  body:             'test',
  out_trade_no:     'test003', # prepay order number
  total_fee:        '100',          # 注意：单位是分，不是元
  spbill_create_ip: '127.0.0.1',
  notify_url:       'http://fannybay.net/',
  trade_type:       'JSAPI',
  nonce_str:        SecureRandom.uuid.tr('-', ''),
  openid:          'obr8rt5nlhaNjBgB6rKE0OcTxDGk'
}
p WxPay::Service.invoke_unifiedorder pay_params







# params = {
#   body: '测试商品',
#   out_trade_no: 'test003',
#   total_fee: 1,
#   spbill_create_ip: '127.0.0.1',
#   notify_url: ERB::Util.url_encode('http://making.dev/notify'),
#   trade_type: 'JSAPI',
#   nonce_str: "5K8264ILTKCH16CQ2502SI8ZNMTM67VS",
#   openid: "oah0RuOMkP2Kurp48bweSoaDqoEM"
# }

