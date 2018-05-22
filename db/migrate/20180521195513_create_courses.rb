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
      t.string :refund_policy, default: ""
      t.string :currency
      t.string :slug

      t.timestamps
    end
  end
end
