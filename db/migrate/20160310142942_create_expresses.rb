class CreateExpresses < ActiveRecord::Migration
  def change
    create_table :expresses do |t|
      t.string  :name
      t.string  :code
      t.integer :position
    end
  end
end
