class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string  :province_code
      t.string  :city_code
      t.string  :name
      t.integer :position, default: 0
      t.timestamps
    end
  end
end
