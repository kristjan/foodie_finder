module Instagram
  def self.photos_of_food(token)
    photos = photos_with_locations(token)
    venues = Foursquare.find_food_venues(photos.map { |photo|
      photo["data"]["location"]
    })
    photos.each {|photo|
      id = photo["data"]["location"]["id"]
      photo["foursquare_venue"] = venues[id]
    }.select{|photo| photo["foursquare_venue"]}
  end

  def self.photos_with_locations(token)
    feed = Singly::Client.new(token).instagram.feed(:limit => 500)
    located = feed.select do |photo|
      location = photo["data"]["location"]
      location && !location["name"].blank?
    end
    located
  end
end
