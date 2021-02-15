class MusicLibraryController
    #sleep 2
    def initialize(path = './db/mp3s')
        importer = MusicImporter.new(path)
        importer.import
    end

    def list_songs
        @sorted_songs = Song.all.sort_by{|song| song.name}
        @sorted_songs.each_with_index do |song, index|  
            puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" 
        end
        #binding.pry
    end

    def list_artists
        sorted_artist = Artist.all.sort_by{|artist| artist.name}
        sorted_artist.each_with_index do |artist, index|
            puts "#{index+1}. #{artist.name}"
        end
        
    end

    def list_genres
        sorted_genre = Genre.all.sort_by{|genre| genre.name}
        sorted_genre.each_with_index do |genre, index|
            puts "#{index+1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.chomp
        if Artist.find_by_name(user_input)
            artist_songs_sorted = Song.all.select{|song| song.artist.name == user_input}.sort_by{|song| song.name}
                artist_songs_sorted.each_with_index do |song, index|
                puts "#{index+1}. #{song.name} - #{song.genre.name}"
            end
        end
    end 

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.chomp
        if Genre.find_by_name(user_input)
            same_genre_songs_sorted = Song.all.select{|song| song.genre.name == user_input}.sort_by{|song| song.name}
                same_genre_songs_sorted.each_with_index do |song, index|
                puts "#{index+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end 

    def play_song
        puts "Which song number would you like to play?"
        user_input = gets.strip.to_i
        index = user_input-1
        
        #if user_input.between?(0,Song.all.length-1)
        if (1..Song.all.length-1).include?(index)
            sorted_songs = Song.all.sort_by{|song| song.name}
            #binding.pry
            user_song = sorted_songs[index]
            song_name = user_song.name
            artist_name= user_song.artist.name 
            #binding.pry
            #song_name = Song.all[user_input-1].name
            #artist_name = Song.all[user_input-1].artist.name
            puts "Playing #{song_name} by #{artist_name}"
       end
    end

    def call
        user_input = ' '
        while user_input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"   
            user_input = gets.chomp
            case user_input 
            when "list artists"
                list_artists
            when "list songs"
                list_songs
            when "list genres"
                list_genres
            when "list artist"
                list_songs_by_artist
            when "list genre"
                list_songs_by_genre
            when "play song"
                play_song
            else
                "invalid input! try again !"
            end
        end
    end

end

##music= MusicLibraryController.new(path = './db/mp3s')
#music.list_songs