class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.references :instructor
      t.references :course
      t.string :title
      t.string :slug

      t.timestamps
    end

    add_index :tracks, :title
  end
end
