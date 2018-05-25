class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :instructor
      t.string :title
      t.text :image_data
      t.text :content
      t.string :slug

      t.timestamps
    end
  end
end
