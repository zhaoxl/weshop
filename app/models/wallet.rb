class Wallet < ActiveRecord::Base
  class InsufficientBalanceException < Exception
  end
end
