require 'chunky_png'
require 'rqrcode'

require 'tianji_qrcode_png/version'
require 'tianji_qrcode_png/sequence'
require 'tianji_qrcode_png/image'
require 'tianji_qrcode_png/qrcode_extensions'

RQRCode::QRCode.send :include, TianjiQRCodePNG::QRCodeExtensions
