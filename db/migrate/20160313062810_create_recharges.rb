class CreateRecharges < ActiveRecord::Migration
  def change
    create_table :recharges do |t|

      t.timestamps
    end
  end
end
