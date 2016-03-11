class Member::DistributionsController < Member::BaseController
  def index
    @distribution = current_user.distribution
    redirect_to member_index_index_path and return if @distribution.blank?
  end
  
  def new
    @distribution = current_user.build_distribution
  end
  
  def create
    distribution = Distribution.new(post_params)
    distribution.save
    
    redirect_to member_distributions_path, notice: '提交成功，请耐心等待审核结果'
  end
  
  def qrcode
    if current_user.qrcode.blank?
      qrcode = RQRCode::QRCode.new("#{Settings.base}/wechat/login?recommend=#{current_user.id}", :size => 6, :level => :h)
      png = qrcode.to_img(ChunkyPNG::Color::TRANSPARENT, ChunkyPNG::Color.rgb(0, 0, 0)).resize(215, 215)   
      qrcode = ::ChunkyPNG::Image.from_file(File.join(Rails.root, "public/images/qrcode_layout.png")).compose!(png, 138, 410)
    
      qrcode.save("tmp/qrcodes/#{current_user.id}.png")
      current_user.update_attribute(:qrcode, File.open("tmp/qrcodes/#{current_user.id}.png"))
      sleep(0.5)
      File.delete("tmp/qrcodes/#{current_user.id}.png")
    end
    
    render layout: false
  end
  
  def withdraw
    
  end
  
  def withdraw_save
    
  end
  
  private
  
  def post_params
    params.require(:distribution).permit!
  end
end
