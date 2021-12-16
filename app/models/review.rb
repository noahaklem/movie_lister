class Review

  @@all = []

  attr_reader :content, :media, :user

  def initialize(content, media, user)
    @content, @media, @user = content, media, user
    @@all << self
  end

  def self.all
    @@all
  end

  def username
    user.username
  end


end