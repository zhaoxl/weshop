class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string  :name
    end
  end
end
