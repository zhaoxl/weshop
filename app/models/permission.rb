class Permission < ActiveRecord::Base
  acts_as_nested_set
  default_scope { where(hide: false) }
  
	has_and_belongs_to_many :roles, :join_table => :roles_permissions
  
  ALLOW_CONTROLLERS = {
    'banners' => 'Banner', 
    'coupon_templates' => '代金卷模板', 
    'coupons' => '代金卷', 
    'distribution_settings' => '分销设置',
    'distributions' => '分销',
    'orders' => '订单',
    'product_categories' => '商品分类',
    'products_logos' => '商品图标',
    'products' => '商品',
    'settings' => '设置',
    'users' => '用户',
    'withdraws' => '提现',
    'recharge_cards' => '充值卡',
    'single_articles' => '单页文章'
  }
  
  REJECT_ACTIONS = [:find_data, :post_params]
  
  scope :get_names, -> { select(:name).group(:name).map(&:name) }
  
  def self.refresh
    Dir.glob(Permission::ALLOW_CONTROLLERS.keys.map{|controller| "#{Rails.root}/app/controllers/admin/#{controller}_controller.rb"}).each do |controller_file|
      File.open(controller_file) do |file|
        controller_name = controller_file.match(/([a-z_]+)_controller.rb/)[1]
        unless parent_controller = Permission.where(controller: controller_name, action: nil).first
          parent_controller = Permission.new(controller: controller_name, action: nil)
          parent_controller.save
        end
        file.each do |line|
          if line =~ /def\s([a-zA-Z0-9_]+)/
            action = $1
            next if action.blank?
            next if Permission::REJECT_ACTIONS.include?(action)
            next if Permission.where(controller: controller_name, action: action).exists?
            
            Permission.create(controller: controller_name, action: action, parent_id: parent_controller.id)
          end
        end
      end
    end
    
  end
end
