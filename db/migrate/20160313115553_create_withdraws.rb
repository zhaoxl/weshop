class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.references  :user
      t.decimal     :amount, :precision => 10, :scale => 2, default: 0
      t.string      :state
      t.timestamps
    end
  end
end
