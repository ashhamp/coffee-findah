require "net/http"
require "json"
require 'dotenv'
Dotenv.load
require 'pry'

class CoffeeShop
  attr_reader :lat, :lng, :data

  def initialize(lat, lng)
    @lat = lat
    @lng = lng
    @data = create_coffee_shop_data
  end

  private

   def create_coffee_shop_data
    response = Net::HTTP.get(uri)
    JSON.parse(response)
   end

   def uri
    key = ENV["GOOGLE_PLACES_API_KEY"]
    URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=1000&keyword=coffee&key=#{key}")
   end

end
