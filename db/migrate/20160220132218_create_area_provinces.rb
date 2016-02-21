class CreateAreaProvinces < ActiveRecord::Migration
  def change
    create_table :area_provinces do |t|
      t.string  :code
      t.string  :name
      t.integer :position, default: 0
    end
  end
end
