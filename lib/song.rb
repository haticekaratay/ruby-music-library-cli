class Song 
    @@all = []
    attr_accessor :name 
    attr_reader :artist ,:genre
    
    def initialize(name,artist_object = nil,genre_object = nil)
        if artist_object #!= nil 
            self.artist=(artist_object)
        end
        if genre_object #!=nil
            self.genre=(genre_object)
        end
        @name = name

    end

    def self.find_by_name(song_name)
        @@all.detect{|song| song.name == song_name}
    end

    def self.find_or_create_by_name(song_name)
        if !find_by_name(song_name)
            self.create(song_name)
        else
            self.find_by_name(song_name)
        end
        #self.find_by_name(song_name) || self.create(name)
    end

    def self.new_from_filename(filename) #filename= "Thundercat - For Love I Come - dance.mp3"
        #binding.pry
        file_name = filename.gsub(/(\.mp3)/,'')
        artist_name= file_name.split(" - ")[0]
        song_name = file_name.split(" - ")[1]
        genre_name = file_name.split(" - ")[2]
        
        new_song = Song.find_or_create_by_name(song_name)
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        new_song.artist=artist  #or song.artist_name = artist_name
        new_song.genre = genre
        new_song
        
    end

    def self.create_from_filename(filename)
        file = self.new_from_filename(filename)
    end

    def genre=(genre_object)
        @genre = genre_object
        if !genre_object.songs.detect{|song| song == self} 
            genre_object.songs << self
        end
    end

    def artist=(artist_object) 
       @artist = artist_object
       artist_object.add_song(self)
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

    def self.create(song_name)
        new_song = Song.new(song_name)

        new_song.save

        new_song
    end
end