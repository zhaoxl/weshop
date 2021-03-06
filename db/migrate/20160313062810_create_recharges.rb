class CreateRecharges < ActiveRecord::Migration
  def change
    create_table :recharges do |t|
      t.references  :user
      t.string      :scode
      t.decimal     :amount, :precision => 10, :scale => 2, default: 0
      t.string      :state
      t.timestamps
    end
  end
end
