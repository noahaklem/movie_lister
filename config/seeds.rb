MediaAPI.new.movie_response.each {|movie| Movie.new(movie) if movie['media_type'] == "movie"}
MediaAPI.new.show_response.each {|show| Show.new(show) if show['media_type'] == "tv"}

spongebob = User.find_or_create("spongebob")

m = Movie.all.first
m.add_review("wowzers", spongebob)
m.add_review("Messages are tight!", spongebob)

s = Show.all.first
s.add_review("here's something new", spongebob)
s.add_review("i guess i should watch this", spongebob)