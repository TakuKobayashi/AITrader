class CreateNewsResources < ActiveRecord::Migration[5.1]
  def change
    create_table :news_resources do |t|
      t.string :title, null: false
      t.string :type
      t.string :news_resource_id
      t.string :url, null: false
      t.text :body, null: false
      t.datetime :published_at, null: false
      t.text :options
    end
    add_index :news_resources, :published_at
    add_index :news_resources, :news_resource_id
    add_index :news_resources, :url
  end
end
