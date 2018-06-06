class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.references :instructor
      t.references :category
      t.references :subcategory
      t.string :title
      t.text :image_data
      t.string :tagline
      t.string :language
      t.text :requirements
      t.text :description
      t.text :highlights
      t.text :target
      t.boolean :paid, default: false
      t.decimal :price, precision: 9, scale: 2
      t.string :currency
      t.integer :refund_policy, default: 0
      t.string :slug

      t.timestamps
    end

    add_index :courses, :title
    add_index :courses, :tagline
    add_index :courses, :price
    add_index :courses, :currency
  end
end
