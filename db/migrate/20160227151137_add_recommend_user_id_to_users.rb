class AddRecommendUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recommend_user_id, :integer
  end
end
