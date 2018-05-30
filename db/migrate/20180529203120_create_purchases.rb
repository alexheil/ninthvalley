class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.references :course
      t.references :instructor
      t.references :student
      t.string :stripe_charge_id
      t.boolean :use_your_card, default: false

      t.timestamps
    end
  end
end
