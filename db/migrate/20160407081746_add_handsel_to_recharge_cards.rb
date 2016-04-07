class AddHandselToRechargeCards < ActiveRecord::Migration
  def change
    add_column :recharge_cards, :handsel, :decimal, :precision => 10, :scale => 2, default: 0
  end
end
