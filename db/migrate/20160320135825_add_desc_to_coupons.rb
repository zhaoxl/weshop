class AddDescToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :desc, :string
  end
end
