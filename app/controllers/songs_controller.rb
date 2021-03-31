class SongsController < ApplicationController
    get '/songs' do
        @songs = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do
        @song = Song.new
        erb :'/songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    post '/songs' do
        @song = Song.create(name: params["Name"])
        @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
        genres = params[:genres]
        genres.each do |genre|
            @song.genres << Genre.find(genre)
        end
        @song.save
        flash[:notice]= "Successfully created song."
        redirect to "songs/#{@song.slug}"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/edit"
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.name = params["Name"]
    
        if Artist.find_by(name: params["Artist Name"])
          if @song.artist.name != params["Artist Name"]
            @song.artist = Artist.find_by(name: params["Artist Name"])
          end
        else
            @song.artist = Artist.create(name: params["Artist Name"])
        end

        if @song.genres
            @song.genres.clear
        end
        genres = params[:genres]
        genres.each do |genre|
            @song.genres << Genre.find(genre)
        end
    
        @song.save
        flash[:notice]= "Successfully updated song."
        redirect to "songs/#{@song.slug}"
    end
end