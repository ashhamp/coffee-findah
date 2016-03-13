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
    URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=42.3515662,-71.0613815&radius=1000&keyword=coffee&key=#{key}")
   end
binding.pry
create_coffee_shop_data['results'].each do |shop|
  puts shop['name']
  puts shop['vicinity']
end


to get html link from JSON: create_coffee_shop_data['results'][0]['photos'].first['html_attributions'].first

to get name from JSON: create_coffee_shop_data['results'][0]['name']
to get address from JSON: create_coffee_shop_data['results'][0]['vicinity']
