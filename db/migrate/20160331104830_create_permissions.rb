class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string  :name
      t.string  :controller
      t.string  :action
      t.text    :description
      t.boolean :hide, default: false
      
      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true

      # optional fields
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0
      
      t.timestamps
    end
  end
end
