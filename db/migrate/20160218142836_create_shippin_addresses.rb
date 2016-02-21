class CreateShippinAddresses < ActiveRecord::Migration
  def change
    create_table :shippin_addresses do |t|
      t.references  :user
      t.integer     :province_id
      t.integer     :city_id
      t.integer     :street_id
      t.string      :detail, limit: 500
      t.string      :name
      t.string      :phone
      t.boolean     :default, default: false
    end
  end
end
