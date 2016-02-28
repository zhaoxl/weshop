class DistributionIncome < ActiveRecord::Base
  belongs_to  :buy_user
  belongs_to  :distribution
  belongs_to  :product
  belongs_to  :order
  belongs_to  :order_product
end
