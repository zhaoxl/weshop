class CreateRechargeCardCategories < ActiveRecord::Migration
  def change
    create_table :recharge_card_categories do |t|
      t.string  :name
      t.decimal :price, :precision => 10, :scale => 2
    end
  end
end
