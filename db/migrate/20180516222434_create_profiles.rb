class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :instructor
      t.references :student
      t.string :first_name, default: ""
      t.string :last_name, default: ""
      t.text :image_data
      t.string :website, default: ""
      t.string :linkedin_handle, default: ""
      t.string :linkedin_url, default: ""
      t.string :twitter_handle, default: ""
      t.string :twitter_url, default: ""
      t.string :youtube_handle, default: ""
      t.string :youtube_url, default: ""
      t.text :biography, default: ""

      t.timestamps
    end
  end
end
