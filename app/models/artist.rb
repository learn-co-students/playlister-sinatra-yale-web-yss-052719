class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

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
