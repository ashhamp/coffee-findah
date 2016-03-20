require "net/http"
require "json"
require 'dotenv'
Dotenv.load

class CoffeeShopLocations
  attr_reader :lat, :lng, :data

  def initialize(lat, lng)
    @lat = lat
    @lng = lng
    @data = create_coffee_shop_data
  end

  def place_id
    @data['results']
  end

  private

   def create_coffee_shop_data
    response = Net::HTTP.get(uri)
    JSON.parse(response)
   end

   def uri
    key = ENV["GOOGLE_PLACES_API_KEY"]
    URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&rankby=distance&keyword=coffee&key=#{key}")
   end
end
