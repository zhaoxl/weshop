class CreateDistributions < ActiveRecord::Migration
  def change
    create_table :distributions do |t|
      t.references  :user
      t.integer :level
      t.decimal :score, default: 0, :precision => 10, :scale => 2
      t.string  :state
      t.string  :phone
      t.string  :city
      t.string  :readme, limit: 2000
      t.timestamps
    end
  end
end
