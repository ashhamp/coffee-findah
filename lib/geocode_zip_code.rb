require "net/http"
require "json"
require 'dotenv'
Dotenv.load
require 'pry'

class GeoCodeZipCode
  attr_reader :data, :zip_code

  def initialize(zip_code)
    @zip_code = zip_code
    @data = create_geocode_data
  end

  def lat
    @data['results'].first['geometry']['location']['lat']
  end

  def lng
    @data['results'].first['geometry']['location']['lng']
  end

  private

   def create_geocode_data
    response = Net::HTTP.get(uri)
    JSON.parse(response)
   end

   def uri
    key = ENV["GOOGLE_PLACES_API_KEY"]
    URI("https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:#{@zip_code}&key=#{key}")
   end
end
