module TianjiQRCodePNG
  class Image
    BLACK = ::ChunkyPNG::Color::BLACK
    WHITE = ::ChunkyPNG::Color::WHITE	
    TRANSPARENT = ::ChunkyPNG::Color::TRANSPARENT	

    def initialize(qr_code)
      @sequence = Sequence.new(qr_code)
    end

    #重写render方法，加入二维码颜色和边框参数
    def render(bg_color, color, border)
      @sequence.border = border.to_i
      png = blank_img(bg_color)
      @sequence.dark_squares_only do |x, y|
        png[y + @sequence.border_width(), x + @sequence.border_width()] = color
      end
      return png
    end

    private

    # Returns the size of the image
    def img_size()
      @img_size ||= @sequence.img_size() + @sequence.border_width() * 2
    end

    # Returns an appropriately sized, blank (white) image
    def blank_img bg_color = WHITE
      ::ChunkyPNG::Image.new(img_size(), img_size(), bg_color)
    end
  end
end

