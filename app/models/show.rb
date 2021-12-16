class Show

  attr_reader :id, :name, :poster, :overview, :vote_average, :first_air_date

  @@all = []

  def initialize(hash)
    @id = hash['id']
    @name = hash['name']
    @poster = hash['poster_path']
    @overview = hash['overview']
    @vote_average = hash['vote_average']
    @first_air_date = hash['first_air_date']
    save
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.find_by_name(name)
    self.all.find { |show| show.name == name }
  end

  def print_details
    puts self.name
    puts "Overview: #{self.overview}"
    puts "Rating: #{self.vote_average}"
    puts "Release Date: #{self.first_air_date}"
  end

  def add_review(content, user)
    Review.new(content, self, user)
  end

  def reviews
    Review.all.select {|review| review.media == self}
  end

  def print_reviews
    if self.reviews.any?
      reviews.each {|review| puts "#{review.username} #{review.content}" }
    else
      puts "#{name} has no reviews yet! Be the first to add one!"
    end
  end

  def add_location(provider_id, provider_name)
    Location.new(provider_id, provider_name, self)
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