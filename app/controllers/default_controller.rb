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

  def food
    @photos = Instagram.photos_of_food(ENV['SINGLY_TOKEN'])
  end

private

  def access_token
    session[:access_token]
  end

  SINGLY_API_BASE = "https://api.singly.com"

  def profiles_url
    "#{SINGLY_API_BASE}/profiles"
  end
end
