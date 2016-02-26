class AddDescriptionToOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :description, :string
  end
end
