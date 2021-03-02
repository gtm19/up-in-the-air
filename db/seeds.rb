# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'uri'
require 'open-uri'
require 'net/http'
require 'openssl'
require 'json'


def aviationstack_data(offset)

  aviation_key = ENV.fetch('AVIATIONSTACK_API_KEY')
  end_point = "http://api.aviationstack.com/v1/airports?access_key=#{aviation_key}&offset=#{offset}"
  url = URI.parse(end_point)

  http = Net::HTTP.new(url.host, url.port)
  request = Net::HTTP::Get.new(url)

  response = http.request(request)
  JSON.parse(response.body)
end


# Create city_airports

aviation = aviationstack_data(0)
airports = aviation["data"]
pagination = aviation["pagination"]

pages = pagination["total"]/pagination["limit"]
limit = pagination["limit"]

page = 0
offset = 0

loop do

  aviation = aviationstack_data(offset)
  airports = aviation["data"]

  airports.each do |airport|
    puts airport["country_name"]
  end

  page += 1
  offset = (page) * limit
  break if page > 1
end


