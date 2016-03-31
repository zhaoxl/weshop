class Permission < ActiveRecord::Base
  acts_as_nested_set
  
	has_and_belongs_to_many :roles, :join_table => :shop_roles_permissions
  
  ALLOW_CONTROLLERS = {'member_admins' => '员工', 'category_product_items' => '分类商品', 'member_categories' => '分类', 'members' => '登录注册', 'orders' => '订单', 'products' => '商品', "roles"=>"角色管理"}
  
  REJECT_ACTIONS = []
  
  scope :enable,-> { where(disabled: false) }
  scope :get_names, -> { select(:name).group(:name).map(&:name) }
  
  def self.refresh
    Dir.glob(Permission::ALLOW_CONTROLLERS.keys.map{|controller| "#{Rails.root}/app/controllers/member/#{controller}_controller.rb"}).each do |controller_file|
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
