class Artist < ActiveRecord::Base
    include ApplicationRecord
    has_many :songs
    has_many :genres, through: :songs

    def self.find_by_slug(slug)
        self.all.find do |obj|
            obj.slug == slug
        end
    end
end