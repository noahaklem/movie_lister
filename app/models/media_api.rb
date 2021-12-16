class MediaAPI 

  attr_reader :movie_response, :show_response

  def initialize
    @movie_response = HTTParty.get("https://api.themoviedb.org/3/trending/movie/day?api_key=cd37ec8948333a41bbe13e4c3979623f")['results']
    @show_response = HTTParty.get("https://api.themoviedb.org/3/trending/tv/day?api_key=cd37ec8948333a41bbe13e4c3979623f")['results']
  end

end