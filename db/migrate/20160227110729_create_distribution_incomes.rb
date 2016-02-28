class CreateDistributionIncomes < ActiveRecord::Migration
  def change
    create_table :distribution_incomes do |t|
      t.references  :distribution
      t.references  :product
      t.references  :order_product
      t.references  :order
      t.integer :buy_user_id
      t.decimal :total, :precision => 10, :scale => 2
      t.timestamps
    end
  end
end
