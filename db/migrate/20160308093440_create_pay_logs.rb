class CreatePayLogs < ActiveRecord::Migration
  def change
    create_table :pay_logs do |t|
      t.string      :item_type
      t.integer     :item_id
      t.string      :pay_type
      t.string      :trade_type
      t.string      :log, limit: 5000
      t.timestamps
    end
  end
end
