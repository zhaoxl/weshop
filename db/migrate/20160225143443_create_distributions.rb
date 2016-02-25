class CreateDistributions < ActiveRecord::Migration
  def change
    create_table :distributions do |t|
      t.references  :user
      t.integer :level
      t.integer :score, default: 0
      t.string  :state
      t.string  :phone
      t.string  :city
      t.string  :readme, limit: 2000
      t.timestamps
    end
  end
end
