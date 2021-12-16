task :environment do 
  require_relative "./config/environment.rb"
end

task :console => :environment do 
  binding.pry
end

task :run => :environment do
  CLI.new
end