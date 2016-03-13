require "net/http"
require "json"
require 'dotenv'
Dotenv.load
require 'pry'


   def create_coffee_shop_data
    response = Net::HTTP.get(uri)
    JSON.parse(response)
   end

   def uri
    key = ENV["GOOGLE_PLACES_API_KEY"]
    URI("https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:01754&key=#{key}")
   end

binding.pry
create_coffee_shop_data
binding.pry
#
# to get latitude: create_coffee_shop_data['results'][0]['geometry']['location']['lat']
# to get longitude: create_coffee_shop_data['results'][0]['geometry']['location']['lng']
