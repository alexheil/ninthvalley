class CreateBlogPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :image
      t.text :content
      t.string :slug

      t.timestamps
    end

    add_index :blog_posts, :title
  end
end
