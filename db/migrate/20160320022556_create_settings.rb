class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string  :key
      t.string  :desc
      t.text    :value
    end
  end
end
