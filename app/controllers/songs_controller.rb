class SongsController < ApplicationController

get '/songs' do
    @songs = Song.all
    erb :"/songs/index"
end

get '/songs/new' do
    @genres = Genre.all
    erb :"/songs/new"
end

get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :"/songs/edit"
end

get "/songs/:slug" do 
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/show"
end

post "/songs" do
    artist = Artist.find_or_create_by(name: params[:artist])
    song = Song.create(name: params[:name], artist_id: artist.id)
    params[:genres].each do |genre|
        SongGenre.create(song: song, genre: Genre.find(genre))
    end
    redirect to "/songs/#{song.slug}"
end

patch "/songs/:slug" do 
    @song = Song.find_by_slug(params[:slug])
    @song.update(name: params[:name])
    @song.update(artist_id: Artist.find_or_create_by(name: params[:artist]).id)
    # remove all SongGenres
    @song.song_genres.destroy_all
    # add new SongGenres
    params[:genres].each do |genre|
        SongGenre.create(song: @song, genre: Genre.find(genre))
    end
    redirect to("/songs/#{@song.slug}")
end

end
