class AddKeyToSingleArticles < ActiveRecord::Migration
  def change
    add_column :single_articles, :key, :string
  end
end
