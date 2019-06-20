class CreateSongGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :song_genres do |x|
      x.integer :song_id
      x.integer :genre_id
    end
  end
end
