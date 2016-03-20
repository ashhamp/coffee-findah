require 'sinatra'
require_relative 'models/coffee_shop_locations'
require_relative 'models/coffee_shop_details'
require_relative 'models/geocode_address'
require_relative 'models/geocode_zip_code'

get '/' do
  redirect '/coffee_shops'
end

get '/coffee_shops' do
  erb :index
end


get '/coffee_shops/by_address' do

  @street = params['street']
  @town = params['town']
  @state = params['state']

  unless @town.strip.empty? || @state.strip.empty?
    @geocode_address = GeoCodeAddress.new(@street, @town, @state)
    @results_address = CoffeeShopLocations.new(@geocode_address.lat, @geocode_address.lng)
  end

  erb :address
end

get '/coffee_shops/by_zip' do

  @zip_code = params['zip_code']

  unless @zip_code.strip.empty?
    @geocode_zip = GeoCodeZipCode.new(@zip_code)
    @results_zip = CoffeeShopLocations.new(@geocode_zip.lat, @geocode_zip.lng)
  end

  erb :zip_code
end

get '/coffee_shops/:place_id' do
  @place_id = params['place_id']

  @results = CoffeeShopDetails.new(@place_id)

  @hours = @results.data['result']['opening_hours']

  erb :show
end
