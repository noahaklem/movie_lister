class CLI

  attr_reader :media, :user

  def initialize
    @prompt = TTY::Prompt.new
    welcome
    menu
  end

  def welcome
    puts "Hi! Welcome to Movie Lister!"
    puts "\nI am going to help you find trending movies or shows and where to watch them."
  end

  def menu
    if @user
      input = @prompt.enum_select("\nWhat would you like to do #{@user.username}?", [
        "See Trending Movies", 
        "See Trending Shows", 
        "See Your Reviews", 
        "Logout", 
        "Exit"])
      case input
      when "See Trending Movies" then show_media(Movie.all)
      when "See Trending Shows" then show_media(Show.all)
      when "See Your Reviews"
        user.print_reviews
        menu
      when "Logout" then logout
      when "Exit" then exit
      end
    else
      prompt_user
      menu
    end
  end

  def show_media(media_data)
    input = @prompt.select("\nWhich movie would you like to view?", media_data.map{ |media| media.class == Movie ? media.title : media.name})
    @media = media_data.first.class.find_by_name(input)
    media_menu
  end

  def prompt_user
    username = @prompt.ask("\nHello! What's your name?")
    @user = User.find_or_create(username)
  end

  def prompt_review
    content = @prompt.ask("What would yo like to say about this title?")
    add_review(content)
    puts "Okay! Added: '#{content}'"
  end

  def media_menu
    puts "\nCurrently viewing:"
    media.print_details
    input = @prompt.enum_select("\nWhat would you like to do", [
      "See Where to Watch",
      "See Reviews",
      "Add A Review", 
      "Back to Main Menu"])
    case input
    when "See Where to Watch" 
      LocationAPI.new(media)
      media.print_locations
      media_menu
    when "See Reviews"
      media.print_reviews
      media_menu
    when "Add A Review"
      prompt_review
      media_menu
    when "Back to Main Menu" 
      menu
    end
  end

  def logout
    @user = nil
    menu
  end

  def exit
    @user = nil
    puts "\nThanks for using Movie Lister!"
  end

  private

  def add_review(content)
    media.add_review(content, user)
  end
end