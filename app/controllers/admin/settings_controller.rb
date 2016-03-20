class Admin::SettingsController < Admin::BaseController
  def new_user_handsel_coupon
    @data = Setting.find_or_initialize_by(key: :new_user_handsel_coupon)
  end
  
  def new_user_handsel_coupon_save
    setting = Setting.find_or_initialize_by(key: :new_user_handsel_coupon)
    setting.value = params[:setting][:value]
    setting.save

    flash[:success] = "编辑成功"
    redirect_to :back 
  end
  
end
