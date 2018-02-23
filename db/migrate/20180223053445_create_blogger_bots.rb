class CreateBloggerBots < ActiveRecord::Migration[5.1]
  def change
    create_table :blogger_bots do |t|
      t.string :blogger_id, null: false
      t.string :from_type
      t.integer :from_id
      t.string :title, null: false
      t.text :body, null: false
      t.float :score, null: false
      t.integer :investigate_start_date, null: false
      t.integer :investigate_end_date, null: false
      t.datetime :published_at, null: false
      t.text :input_body_resources, null: false
      t.text :options
    end
    add_index :blogger_bots, :blogger_id
    add_index :blogger_bots, [:investigate_start_date, :investigate_end_date], name: "blogger_bots_investigate_range_index"
    add_index :blogger_bots, :score
    add_index :blogger_bots, [:from_type, :from_id]
  end
end
