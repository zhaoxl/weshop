class CreateAreaStreets < ActiveRecord::Migration
  def change
    create_table :area_streets do |t|
      t.string  :code
      t.string  :name
      t.string  :city_code
      t.integer :position, default: 0
    end
  end
end
