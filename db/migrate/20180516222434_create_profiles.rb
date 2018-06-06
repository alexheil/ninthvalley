class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :instructor
      t.references :student
      t.string :first_name, default: ""
      t.string :last_name, default: ""
      t.text :image_data
      t.string :city, default: ""
      t.string :state, default: ""
      t.string :country, default: ""
      t.string :website, default: ""
      t.string :twitter_handle, default: ""
      t.string :twitter_url, default: ""
      t.string :youtube_handle, default: ""
      t.string :youtube_url, default: ""
      t.text :biography, default: ""

      t.timestamps
    end

    add_index :profiles, :first_name
    add_index :profiles, :last_name
  end
end
