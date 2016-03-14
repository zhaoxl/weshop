class AddFrontLogoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :front_logo, :string
  end
end
