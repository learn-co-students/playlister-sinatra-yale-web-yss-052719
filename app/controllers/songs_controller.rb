class SongsController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :"/songs/index"
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :"/songs/new"
    end

    post '/songs' do
        song = Song.create(name: params[:Name])
        artist = Artist.find_or_create_by(name: params[:artist])
        
        song.artist = artist

        genres = Genre.all.select do |genre|
            value = false
            params[:genre].each do |id|
                if genre.id.to_s == id
                    value = true
                    break
                end
            end
            value
        end
        song.genres = genres
        song.save
        redirect to("/songs/#{song.slug}")
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :"/songs/show"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do
        song = Song.find_by_slug(params[:slug])
        artist = Artist.find_or_create_by(name: params[:artist])
        
        song.artist = artist

        genres = Genre.all.select do |genre|
            value = false
            params[:genre].each do |id|
                if genre.id.to_s == id
                    value = true
                    break
                end
            end
            value
        end
        song.genres = genres
        song.save
        redirect to("/songs/#{song.slug}")
    end

    
end