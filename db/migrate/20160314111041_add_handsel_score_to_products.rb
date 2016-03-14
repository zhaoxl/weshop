class AddHandselScoreToProducts < ActiveRecord::Migration
  def change
    add_column :products, :handsel_score, :integer
  end
end
