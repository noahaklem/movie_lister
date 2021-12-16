class User
  attr_accessor :username

  @@all = [] 

  def self.all
    @@all
  end

  def self.create(username)
    user = self.new
    user.username = username
    self.all << user
    return user
  end

  def self.find_by_username(username)
    self.all.find {|user| user.username == username}
  end

  def self.find_or_create(username)
    self.find_by_username(username) || self.create(username)
  end

  def reviews
    Review.all.select {|review| review.user == self }
  end

  def media
    reviews.map {|review| review.media }.uniq
  end

  def print_reviews
    if self.reviews.any?
      reviews.each do |review| 
        if review.media.class == Show
          puts "Reviewed the show #{review.media.name}: #{review.content}"
        else
          puts "Reviewed the movie #{review.media.title}: #{review.content}" 
        end
      end
    else
      puts "You've written no reviews. Add one now!"
    end
  end

end