class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references  :user
      t.string      :scode
      t.decimal     :fare, :precision => 10, :scale => 2
      t.decimal     :total_fee, :precision => 10, :scale => 2
      t.string      :state
      t.string      :remark
      t.string      :receiver_name
      t.string      :receiver_phone
      t.string      :receiver_address
      t.timestamps
    end
  end
end
