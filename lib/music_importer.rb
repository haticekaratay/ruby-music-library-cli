class MusicImporter

    attr_reader :path

    def initialize(path)
        @path = path
    end

    def path
        @path
    end

    def files
        Dir.entries(path).select{|filename| filename.end_with?(".mp3")}
        #binding.pry
        #Dir.entries return an array of path items
        # pry(#<MusicImporter>)> Dir.entries(path)
        #=> [".", ".." ,
        #"Jurassic 5 - What's Golden - hip-hop.mp3",
        #"Real Estate - It's Real - hip-hop.mp3",
        #"Real Estate - Green Aisles - country.mp3",
        #"Thundercat - For Love I Come - dance.mp3",
        #"Action Bronson - Larry Csonka - indie.mp3"]
    end

    def import
        files.each{|file| Song.create_from_filename(file)}
    end


end