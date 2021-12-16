class Movie

  attr_reader :id, :title, :poster, :overview, :vote_average, :release_date

  @@all = []

  def initialize(hash)
    @id = hash['id']
    @title = hash['title']
    @poster = hash['poster_path']
    @overview = hash['overview']
    @vote_average = hash['vote_average']
    @release_date = hash['release_date']
    save
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.find_by_name(title)
    self.all.find { |movie| movie.title == title }
  end

  def print_details
    puts "\n#{self.title}"
    puts "Overview: #{self.overview}"
    puts "Rating: #{self.vote_average}"
    puts "Release Date: #{self.release_date}"
  end

  def add_review(content, user)
    Review.new(content, self, user)
  end

  def add_location(provider_id, provider_name)
    Location.new(provider_id, provider_name, self)
  end

  def reviews
    Review.all.select {|review| review.media == self}
  end

  def print_reviews
    if self.reviews.any?
      reviews.each {|review| puts "#{review.username}: #{review.content}" }
    else
      puts "#{title} has no reviews yet! Be the first to add one!"
    end
  end

  def locations
    Location.all.select {|location| location.media == self}
  end

  def print_locations
    if self.locations.any?
      locations.each_with_index do |location, i| 
        if !location.providers.empty?
          puts "\n#{location.provider_option.upcase} it here:"
          location.providers.each_with_index do |provider, i|
            puts "#{i +1}. #{provider}"
          end
        end
      end
    else
      puts "#{title} may still be in theaters!"
    end
  end

end