class Genre < ActiveRecord::Base
    include ApplicationRecord
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def self.find_by_slug(slug)
        self.all.find do |obj|
            obj.slug == slug
        end
    end
end