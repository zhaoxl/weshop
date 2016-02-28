class CreateDistributionSettings < ActiveRecord::Migration
  def change
    create_table :distribution_settings do |t|
      t.integer :v1
      t.integer :v2
      t.integer :v3
    end
  end
end
