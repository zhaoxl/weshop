class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.references  :user
      t.decimal :balance, :precision => 10, :scale => 2, default: 0
      t.decimal :lock, :precision => 10, :scale => 2, default: 0
      t.integer :score, default: 0
    end
  end
end
