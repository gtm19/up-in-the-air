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
# Get City Airport Date

  aviation_key = ENV.fetch('AVIATIONSTACK_API_KEY')
  end_point = "http://api.aviationstack.com/v1/airports?access_key=#{aviation_key}&offset=#{offset}"
  url = URI.parse(end_point)

  http = Net::HTTP.new(url.host, url.port)
  request = Net::HTTP::Get.new(url)

  response = http.request(request)
  JSON.parse(response.body)
end

def load_city_airports
# Create city_airports
  aviation = aviationstack_data(0)
  airports = aviation["data"]
  pagination = aviation["pagination"]

  pages = (pagination["total"]/pagination["limit"]).floor
  limit = pagination["limit"]

  puts "Total pages: #{pages}"

  page = 0
  offset = 0
  count = 0

  pages = 10

  loop do
    puts "Page: #{page}"
    aviation = aviationstack_data(offset)
    airports = aviation["data"]

    airports.each do |airport|
      count += 1

      city = City.new
      city.name = airport["airport_name"]
      city.country = airport["country_name"]
      city.latitude = airport["latitude"]
      city.longitude = airport["longitude"]
      city.airport_code = airport["iata_code"]
      city.gmt = airport["gmt"]
      city.city_iata_code = airport["city_iata_code"]
      city.country_iso2 = airport["country_iso2"]
      city.airport_name = airport["airport_name"]
      city.country_name = airport["country_name"]
      city.timezone = airport["timezone"]

      city.save

      puts "#{count}. #{airport["iata_code"]} in #{airport["country_name"]}" if city.id
    end

    break if page == pages
    page += 1
    offset = (page) * limit

  end
end

def create_users
# Create users
  user_array = [
    {firstname: "Pat", lastname: "Sharp", address1: "89 High Street", address2: "Teddington", postcode: "TW11 8HG"},
    {firstname: "Bob", lastname: "Hope", address1: "18 Teddington Park Rd", address2: "Teddington", postcode: "TW11 0AQ"},
    {firstname: "Ken", lastname: "Bruce", address1: "70 London Rd", address2: "Kingston upon Thames", postcode: "KT2 6PY"},
    {firstname: "Lee", lastname: "Mack", address1: "210 Kingston Rd", address2: "Teddington", postcode: "TW11 9JF"},
    {firstname: "Julia", lastname: "Roberts", address1: "113 Heath Rd", address2: "Twickenham", postcode: "TW1 4AZ"}
    ]

  user_array.each do |user|
    p "Creating #{user[:firstname]} #{user[:lastname]}"
    city = City.all.sample
    u = User.new
    u.first_name = user[:firstname]
    u.last_name = user[:lastname]
    u.email = "#{user[:firstname]}.#{user[:lastname]}@upintheair.com"
    u.password = "topsecret"
    u.address_1 = user[:address1]
    u.address_2 = user[:address2]
    u.postcode = user[:postcode]
    u.city_id = city.id
    u.save!
  end
end

def create_trip_estimates
# Create Trip Estimates
  i = 0

  users = User.all
  cities = City.all

  users.each do |user|
    cities.each do |city|
    break unless TripEstimate.where(start_city_id: user.city_id, destination_city: city).empty?
      i += 1
      t = TripEstimate.new
      t.low_cost = rand(0..500)
      t.high_cost = t.low_cost + rand(0..200)
      t.flight_mins = (t.low_cost + t.high_cost)/2
      t.valid_from = Date.parse('01-04-2021')
      t.valid_until = Date.parse('01-04-2022')
      t.start_city_id = user.city_id
      t.destination_city = city
      t.save!

      puts "#{i}. #{t.start_city.name} to #{t.destination_city.name} at #{t.low_cost}"
    end
  end
end

def seed_trip_participant(trip, user, budget, time)
  tp = TripParticipants.new
  tp.user = user
  tp.trip = trip
  tp.budget_preference = budget
  tp.time_preference = time
  tp.save
end

def seed_trip
  lead_user = User.find_by(first_name: "Pat")
  trip = Trip.new
  trip.name = "Away with uni friends"
  trip.description = "After a zoom chat, desperate to meet somewhere in Europe as soon as possible"
  trip.lead_user = lead_user
  trip.save

  seed_trip_participant(trip, lead_user, 400, 250)
  friend = User.find_by(first_name: "Julia")
  seed_trip_participant(trip, friend, 500, 350)
end


# TripEstimate.delete_all
# User.delete_all
# City.delete_all

# load_city_airports
# create_users
# create_trip_estimates

seed_trip


