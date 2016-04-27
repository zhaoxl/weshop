class AddHandselAmountToWallets < ActiveRecord::Migration
  def change
    add_column :wallets, :handsel_amount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
