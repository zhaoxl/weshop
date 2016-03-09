# required
WxPay.appid = Settings.wechat.appid
WxPay.key = Settings.wechat.partnerkey
WxPay.mch_id =  Settings.wechat.mchid.to_s
# pass = Settings.wechat.partnerkey

# cert, see https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=4_3
# using PCKS12
#WxPay.set_apiclient_by_pkcs12(File.read("#{Rails.root}/config/cert/apiclient_cert.p12"), pass)

# optional - configurations for RestClient timeout, etc.
# WxPay.extra_rest_client_options = {timeout: 2, open_timeout: 3}

