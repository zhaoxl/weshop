class CreateRechargeCards < ActiveRecord::Migration
  def change
    create_table :recharge_cards do |t|
      t.references  :recharge_card
      t.references  :user
      t.string      :scode
      t.string      :name
      t.string      :state
      t.decimal :price, :precision => 10, :scale => 2
      t.timestamps
    end
  end
end
