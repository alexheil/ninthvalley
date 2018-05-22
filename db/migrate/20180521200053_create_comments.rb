class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :instructor
      t.references :student
      t.references :video
      t.text :content

      t.timestamps
    end
  end
end
