module TianjiQRCodePNG
  module QRCodeExtensions 
    #to_img方法，加入二维码颜色和边框参数
    def to_img(bg_color = ChunkyPNG::Color::TRANSPARENT, color = ChunkyPNG::Color::BLACK, border = 1)
      return Image.new(self).render(bg_color, color, border)
    end
  end
end

