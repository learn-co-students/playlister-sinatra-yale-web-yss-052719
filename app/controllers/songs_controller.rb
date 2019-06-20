class SongsController < ApplicationController
    get '/songs' do
        @songs_all = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do
        erb :'/songs/new'
    end

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    post '/songs' do
        @artist_id = Artist.find_or_create_by(name: params[:artist_name]).id
        @song = Song.create(name: params[:Name], artist_id: @artist_id)
        params[:genres].each do |id|
            SongGenre.create(song_id: @song.id, genre_id: id)
        end
        redirect to("/songs/#{@song.slug}")
    end
        
    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :"/songs/edit"
    end
    
    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @artist_id = Artist.find_by(name: params[:artist_name]).id
        @song.update(name: params[:song_name], artist_id: @artist_id)
        @song.song_genres.each do |songgenre|
            songgenre.delete
        end
        params[:genres].each do |id|
            SongGenre.create(song_id: @song.id, genre_id: id)
        end
        redirect to("/songs/#{@song.slug}")
    end

end