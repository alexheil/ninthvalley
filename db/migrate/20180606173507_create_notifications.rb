class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :instructor
      t.references :student
      t.references :review
      t.references :comment
      t.references :purchase
      t.references :subscription
      t.string :notice_type
      t.boolean :read, default: false

      t.timestamps
    end

    add_index :notifications, :notice_type
    add_index :notifications, :read
  end
end
