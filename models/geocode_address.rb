require "net/http"
require "json"
require 'dotenv'
Dotenv.load

class GeoCodeAddress
  attr_reader :street, :town, :state, :data

  def initialize(street, town, state)
    @street = street
    @town = town
    @state = state
    @data = create_geocode_data
  end

  def lat
    @data['results'].first['geometry']['location']['lat']
  end

  def lng
    @data['results'].first['geometry']['location']['lng']
  end

  private

  def street_uri
    @street.split(" ").join("+")
  end

  def town_uri
    if @town.split(" ").count > 1
      return @town.split(" ").join("+")
    else
      return @town
    end
  end

 def create_geocode_data
  response = Net::HTTP.get(uri)
  JSON.parse(response)
 end

 def uri
  key = ENV["GOOGLE_PLACES_API_KEY"]
  URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{street_uri},+#{town_uri},+#{@state}&key=#{key}")
 end
end
