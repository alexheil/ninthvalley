class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :instructor
      t.references :student
      t.references :course
      t.integer :rating, default: 3
      t.text :content

      t.timestamps
    end

    add_index :reviews, :rating
  end
end
