class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references  :user
      t.references  :product
      t.integer     :total, defalt: 0
      t.timestamps
    end
  end
end
