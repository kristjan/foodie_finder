require "httparty"

class DefaultController < ApplicationController
  def home
    if access_token
      @profiles = HTTParty.get(profiles_url,
        :query => {:access_token => access_token}
      ).parsed_response
    end
  end

  def friends
    @friends_list = ['brad','jason','merci']
  end

  def feed
    @photos = normalize_photos(Instagram.photos_of_food(access_token))
    @checkins = normalize_checkins(Foursquare.food_checkins(access_token))
    @feed = (@photos + @checkins).sort_by{|item| item["at"].to_i}
  end

private

  def access_token
    session[:access_token]
  end

  SINGLY_API_BASE = "https://api.singly.com"

  def profiles_url
    "#{SINGLY_API_BASE}/profiles"
  end

  def normalize_photos(items)
    items.each do |item|
      item["normalized"] = {
        "user_name" => item["data"]["user"]["full_name"]
      }
    end
    items
  end

  def normalize_checkins(items)
    items.each do |item|
      item["normalized"] = {
        "user_name" => [item["data"]["user"]["firstName"].to_s,
                        item["data"]["user"]["lastName"].to_s].join(' ')
      }
    end
    items
  end
end
