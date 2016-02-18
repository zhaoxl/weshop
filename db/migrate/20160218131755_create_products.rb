class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references  :product_category
      t.string  :name
      t.string  :description
      t.integer :inventory
      t.decimal :old_price, :precision => 10, :scale => 2
      t.decimal :price, :precision => 10, :scale => 2
      t.text    :content
      t.string  :state
      t.integer :position, default: 0
      t.boolean :recommend, default: false
      t.boolean :sticky, default: false
      t.integer :order_products_count
    end
  end
end
