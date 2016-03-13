class DividendLog < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :recommend_user, class_name: 'User'
  belongs_to  :order
end
