class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string  :title
      t.string  :description
      t.string  :url, limit: 500
      t.string  :image
      t.integer :position
      t.timestamps
    end
  end
end
