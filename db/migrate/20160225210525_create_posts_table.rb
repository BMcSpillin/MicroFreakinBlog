class CreatePostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |table|
      table.integer :user_id
      table.string :content
      table.string :image
      table.datetime :timestamp
  end
end
