class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references  :user
      t.string      :item_type
      t.integer     :item_id
      t.string      :desc, limit: 500
      t.string      :scode
      t.decimal     :amount, :precision => 10, :scale => 2, default: 0
      t.string      :state
      t.string      :goto, limit: 500
      
      t.timestamps
    end
  end
end
