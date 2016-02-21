class CreateAreaCities < ActiveRecord::Migration
  def change
    create_table :area_cities do |t|
      t.string  :code
      t.string  :name
      t.string  :province_code
      t.integer :position, default: 0
    end
  end
end
