class LocationAPI 

  attr_reader :response

   def initialize(media)
    if media.class == Show
      @response = HTTParty.get("https://api.themoviedb.org/3/tv/#{media.id}/watch/providers?api_key=cd37ec8948333a41bbe13e4c3979623f")['results']['US']
      Location.new_from_nested_hash(@response, media) 
    else
      @response = HTTParty.get("https://api.themoviedb.org/3/movie/#{media.id}/watch/providers?api_key=cd37ec8948333a41bbe13e4c3979623f")['results']['US']
      Location.new_from_nested_hash(@response, media)
    end
   end

end