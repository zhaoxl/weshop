class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references  :user
      t.integer     :product_id
      t.timestamps
    end
  end
end
