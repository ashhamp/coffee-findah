require "net/http"
require "json"
require 'dotenv'
Dotenv.load

class CoffeeShopDetails
  attr_reader :place_id, :data

  def initialize(place_id)
    @place_id = place_id
    @data = create_place_data
  end

  private

   def create_place_data
    response = Net::HTTP.get(uri)
    JSON.parse(response)
   end

   def uri
    key = ENV["GOOGLE_PLACES_API_KEY"]
    URI("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=#{key}")
   end
end
