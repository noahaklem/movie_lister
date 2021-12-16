class Location 
  
  @@all = []

  attr_reader :provider_option, :media, :providers

  def initialize(provider_option, media)
    @provider_option, @media = provider_option, media
    @providers = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.new_from_nested_hash(nested_hash, media)
    clear
    if nested_hash
      nested_hash.each do |key, value|
        location = self.new(key, media)
        if value.is_a?(Array)
          value.each do |k, v|
            location.providers << k['provider_name']
          end
        end
      end
    end
  end

  def self.clear
    all.clear
  end

end