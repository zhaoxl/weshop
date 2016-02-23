class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.references  :user
      t.references  :order
      t.references  :product
      t.integer     :total
      t.decimal     :amount, :precision => 10, :scale => 2
    end
  end
end
