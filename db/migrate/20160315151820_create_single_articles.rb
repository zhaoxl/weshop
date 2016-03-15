class CreateSingleArticles < ActiveRecord::Migration
  def change
    create_table :single_articles do |t|
      t.string  :title
      t.text    :content
      t.boolean :can_delete, default: true
      t.timestamps
    end
  end
end
