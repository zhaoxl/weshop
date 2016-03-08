class CreatePayLogs < ActiveRecord::Migration
  def change
    create_table :pay_logs do |t|
      t.references  :order
      t.string      :pay_type
      t.string      :trade_type
      t.string      :log, limit: 5000
      t.timestamps
    end
  end
end
