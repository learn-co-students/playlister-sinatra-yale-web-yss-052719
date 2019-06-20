class SongGenre < ActiveRecord::Base
    include ApplicationRecord
    belongs_to :song
    belongs_to :genre

    def self.find_by_slug(slug)
        self.all.find do |obj|
            obj.slug == slug
        end
    end
end