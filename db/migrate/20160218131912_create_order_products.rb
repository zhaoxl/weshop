class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.references  :user
      t.references  :order
      t.references  :product
      t.string      :name
      t.integer     :total
      t.decimal     :price, :precision => 10, :scale => 2
      t.decimal     :amount, :precision => 10, :scale => 2
      t.string      :logo
    end
  end
end
