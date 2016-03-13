require 'sinatra'
require_relative 'lib/coffee_shop'
require_relative 'lib/geocode_address'
require_relative 'lib/geocode_zip_code'
require 'pry'

get '/' do

  erb :index

end

get '/coffee-shops-by-address' do

  @street = params['street']
  @town = params['town']
  @state = params['state']

  @geocode_address = GeoCodeAddress.new(@street, @town, @state)
  @results_address = CoffeeShop.new(@geocode_address.lat, @geocode_address.lng)


  erb :address
end

get '/coffee-shops-by-zip' do

  @zip_code = params['zip_code']

  @geocode_zip = GeoCodeZipCode.new(@zip_code)
  @results_zip = CoffeeShop.new(@geocode_zip.lat, @geocode_zip.lng)

  erb :zip_code
end
