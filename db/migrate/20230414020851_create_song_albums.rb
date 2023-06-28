class CreateSongAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :song_albums do |t|
      t.references :song, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
