class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string  :name
      t.string  :logo
      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0
      t.integer :position, default: 0
    end
  end
end
