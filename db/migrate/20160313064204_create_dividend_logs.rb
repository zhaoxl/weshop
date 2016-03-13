class CreateDividendLogs < ActiveRecord::Migration
  def change
    create_table :dividend_logs do |t|
      t.references  :user
      t.references  :order
      t.integer     :recommend_user_id
      t.decimal     :amount, :precision => 10, :scale => 2, default: 0
      t.timestamps
    end
  end
end
