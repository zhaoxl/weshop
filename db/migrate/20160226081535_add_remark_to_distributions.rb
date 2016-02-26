class AddRemarkToDistributions < ActiveRecord::Migration
  def change
    add_column :distributions, :remark, :string, limit: 2000
  end
end
