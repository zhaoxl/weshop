class CreateShippinAddresses < ActiveRecord::Migration
  def change
    create_table :shippin_addresses do |t|
      t.references  :user
      t.string      :province_code
      t.string      :city_code
      t.string      :street_code
      t.string      :detail, limit: 500
      t.string      :name
      t.string      :phone
      t.boolean     :default, default: false
    end
  end
end
