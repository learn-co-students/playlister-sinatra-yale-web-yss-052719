class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    # https://stackoverflow.com/questions/4308377/ruby-post-title-to-slug
    self.name.downcase.strip.gsub(' ', '-')
  end

  def self.find_by_slug(this_slug)
    self.all.find do |that_slug|
      this_slug == that_slug.slug
    end
  end

end
