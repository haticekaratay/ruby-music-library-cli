require 'pry'
class Artist
    extend Concerns::Findable
    
    @@all = []
    attr_accessor :name , :songs
    
    def initialize(name)
        @name = name
        @songs = []
    end

    def songs
        @songs
    end

    def genres
        artist_genres = self.songs.collect{|song| song.genre}
        artist_genres.uniq
       # binding.pry
    end

    def add_song(song)
        if !@songs.include?(song)
            @songs << song
        end

        if song.artist == nil
            song.artist = self
        end
    end


    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear

    end

    def save
        @@all << self
    end

    def self.create(artist_name)
        new_artist = Artist.new(artist_name)

        new_artist.save

        new_artist
    end
end