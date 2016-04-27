class Member::DistributionsController < Member::BaseController
  def index
    @distribution = current_user.distribution
    # redirect_to member_index_index_path and return if @distribution.blank?
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
      qrcode = ::ChunkyPNG::Image.from_file(File.join(Rails.root, "public/images/qrcode_layout.png")).compose!(png, 136, 365)
    
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
    begin
      amount = params[:amount].to_f
      unless wallet = current_user.wallet
        raise Wallet::InsufficientBalanceException
      end
      wallet.balance -= amount
      wallet.lock += amount
      raise Wallet::InsufficientBalanceException if wallet.balance-wallet.handsel_amount < 0
      wallet.save
      
      Withdraw.create(user: current_user, amount: amount)
      flash[:notice] = "申请成功，请等待处理"
    rescue Wallet::InsufficientBalanceException
      flash[:notice] = "余额不足！"
    end
    
    redirect_to :back
  end
  
  private
  
  def post_params
    params.require(:distribution).permit!
  end
end
