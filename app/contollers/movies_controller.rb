class MovieController < ApplicationController

  get "/movies" do 
    erb :"movies/index"
  end

  
end