class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :instructor
      t.references :student
      t.string :stripe_subscription_id

      t.timestamps
    end
  end
end
