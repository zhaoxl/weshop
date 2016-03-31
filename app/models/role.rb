class Role < ActiveRecord::Base
	include ::ConstantExtend
	has_and_belongs_to_many :member_admins, :join_table => :shop_member_admins_roles
	belongs_to :resource, :polymorphic => true
	has_and_belongs_to_many :permissions, :join_table => :shop_roles_permissions
  
  validates :name, length: { in: 2..8 }, uniqueness: {scope: [:resource_type, :resource_id, :name]}, presence: true
      
  ROLE_SYSTEM = '系统管理员'
	ROLE_MANAGER = '主管'
  #	ROLE_OPERATION = 'operation'
  #	ROLE_CUSTOMER_SERVICE = 'customer_service'
  #	ROLE_FINANCE = 'finance'

	validates :resource_type,
    :inclusion => { :in => Rolify.resource_types },
    :allow_nil => true

	scopify
end
