class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.references :instructor
      t.references :student
      t.references :message
      t.text :content

      t.timestamps
    end
  end
end
