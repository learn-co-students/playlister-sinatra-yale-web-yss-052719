# require 'pry'

class SongsController < ApplicationController
  # use Rack::Flash
  # enable :sessions
  configure do
    set :method_override, true
  end

  get "/songs" do
    @songs = Song.all
    erb :'songs/index'
  end

  get "/songs/new" do
    erb :'songs/new'
  end

  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  post "/songs" do
    # binding.pry
    song = Song.create(name: params[:name])
    song.artist = Artist.create(name: params[:artist_name])
    params[:genres].each do |genre_id|
      SongGenre.create(song_id: song.id, genre_id: genre_id)
    end
    song.save
    # flash[:message] = "Successfully created song."
    redirect to "/songs/#{song.slug}"
  end

  get "/songs/:slug/edit" do
    @song_change = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch "/songs/:slug" do
    song_patch = Song.find_by_slug(params[:slug])
    song_patch.artist = Artist.update(name: params[:artist_name])
    params[:genres].each do |genre_id|
      SongGenre.update(song_id: song.id, genre_id: genre_id)
    end
    song_patch.save
    # flash[:message] = "Successfully edited song."
    redirect to "/songs/#{song.slug}"
  end


end
