class CreateProductLogos < ActiveRecord::Migration
  def change
    create_table :product_logos do |t|
      t.references  :product
      t.string      :logo
      t.integer     :position, default: 0
    end
  end
end
