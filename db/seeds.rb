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
require 'geokit'


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

def basic_cities
  cities = [
    {
      name: "Paris",
      country: "France",
      latitude: 48.864716,
      longitude:	2.349014,
      airport_code: "CDG",
      gmt: "0",
      city_iata_code: "001",
      country_iso2: "FR",
      airport_name: "Charles De Gaulle",
      timezone: "Europe"
    },
    {
      name: "London",
      country: "United Kingdom",
      latitude:	51.5,
      longitude: -0.11,
      airport_code: "LHR",
      gmt: "0",
      city_iata_code: "LHR",
      country_iso2: "GB",
      airport_name: "London Airport",
      timezone: "Europe"
    },
    {
      name: "Berlin",
      country: "Germany",
      latitude:	52.520008,
      longitude: 13.404954,
      airport_code: "SXF",
      gmt: "0",
      city_iata_code: "SXF",
      country_iso2: "DE",
      airport_name: "Berlin Airport",
      timezone: "Europe"
    },
    {
      name: "Florence",
      country: "Italy",
      latitude:	43.76,
      longitude: 11.25,
      airport_code: "FLR",
      gmt: "0",
      city_iata_code: "FLR",
      country_iso2: "IT",
      airport_name: "Florence Airport",
      timezone: "Europe"
    },
    {
      name: "Madrid",
      country: "Spain",
      latitude: 40.41,
      longitude:	-3.73,
      airport_code: "MAD",
      gmt: "0",
      city_iata_code: "MAD",
      country_iso2: "ES",
      airport_name: "Madrid Airport",
      timezone: "Europe"
    }
  ]

  cities.each do |city|
    City.create(city)
  end
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

  loop do
    puts "Page: #{page}"
    aviation = aviationstack_data(offset)
    airports = aviation["data"]

    airports.each do |airport|
      next unless airport["timezone"].match?(/^Europe/)
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
    {first_name: "Pat", last_name: "Sharp", address_1: "89 High Street", address_2: "Teddington", postcode: "TW11 8HG", airport: "LHR"},
    {first_name: "Bob", last_name: "Hope", address_1: "18 Teddington Park Rd", address_2: "Teddington", postcode: "TW11 0AQ", airport: "CDG"},
    {first_name: "Ken", last_name: "Bruce", address_1: "70 London Rd", address_2: "Kingston upon Thames", postcode: "KT2 6PY", airport: "SXF"},
    {first_name: "Lee", last_name: "Mack", address_1: "210 Kingston Rd", address_2: "Teddington", postcode: "TW11 9JF", airport: "FLR"},
    {first_name: "Julia", last_name: "Roberts", address_1: "113 Heath Rd", address_2: "Twickenham", postcode: "TW1 4AZ", airport: "MAD"}
    ]

  user_array.each do |user|
    p "Creating #{user[:first_name]} #{user[:last_name]}"
    city = City.find_by(airport_code: user[:airport])
    user[:email] = "#{user[:first_name]}.#{user[:last_name]}@upintheair.com"
    user[:password] = "topsecret"
    user[:city_id] = city.id
    user.delete(:airport)
    User.create(user)
  end
end

def create_trip_estimates
# Create Trip Estimates
  i = 0

  users = User.all
  cities = City.where("timezone LIKE 'Europe%'")
  # Assuming it costs roughly a £1/mile to fly with a little random adjustment
  users.each do |user|
    cities.each do |city|
      # if city != user.city
        i += 1
        t = TripEstimate.new
        t.flight_mins = time_between(user.city, city)
        t.low_cost = t.flight_mins - rand(0..30)
        t.high_cost = t.flight_mins + rand(20..40)
        t.valid_from = Date.parse('01-04-2021')
        t.valid_until = Date.parse('01-04-2022')
        t.start_city_id = user.city_id
        t.destination_city = city
        t.save!
        puts "#{i}. #{t.start_city.name} (#{t.start_city.country_name}) to #{t.destination_city.name} (#{t.destination_city.country_name}) at best £#{t.low_cost} in #{t.flight_mins} mins"
      # end
    end
  end
end

def time_between(start_city, dest_city)
  Geokit::default_units = :kms
  start = Geokit::LatLng.new(start_city.latitude,start_city.longitude)
  destination = "#{dest_city.latitude},#{dest_city.longitude}"
  distance = start.distance_to(destination)
  # Assume a plane typically flies at 500 km/h when cruising.
  aircraft_speed = 500
  mins = (distance * 60) / aircraft_speed || 1440

  # Flights are typically 45 mins minimum
  mins = 45 if mins < 45
  mins.to_i
end

def seed_trip_participant(trip, user, budget, time)
  tp = TripParticipant.new
  tp.user = user
  tp.trip = trip
  tp.budget_preference = budget
  tp.time_preference = time
  tp.save
end

def seed_trip(trip_name)
  lead_user = User.find_by(first_name: "Pat")
  trip = Trip.new
  trip.name = trip_name
  trip.description = "After a zoom chat, desperate to meet somewhere in Europe as soon as possible"
  trip.lead_user = lead_user
  trip.save!

  puts ("Created trip with Pat Sharpe as lead")
  puts ("Created trip participiants ...")

  seed_trip_participant(trip, lead_user, 400, 250)
  puts ("Pat Sharpe, Budget: £400, Time: 250mins")

  friend = User.find_by(first_name: "Julia")
  seed_trip_participant(trip, friend, 500, 350)
  puts ("Julia Roberts, Budget: £500, Time: 350mins")

  friend = User.find_by(first_name: "Bob")
  seed_trip_participant(trip, friend, 600, 450)
  puts ("Bob Hope, Budget: £600, Time: 450mins")

  trip
end

def seed_potential_destinations(trip)
  # get all the trip participants
  trip_participants = trip.trip_participants
  # get the cities of the participants and shift by 1 
  # (so no-one chooses their city as a potential destination)
  cities = trip_participants.map { |tp| tp.user.city }.rotate

  #For each trip participant, create a potential destination
  date_offset = 0
  trip_participants.each do |trip_participant|
    city = cities.shift
    puts "Creating PD for #{trip_participant.user.name}: #{city.name}, #{city.country}"
    pd = PotentialDestination.new
    pd.city = city
    pd.status = 'submitted'
    trip_participant.potential_destinations << pd

    date_pref = DatePreference.new(
      start_date: Date.parse('01-05-2021') + date_offset,
      end_date: Date.parse('08-05-2021') + date_offset
    )

    date_offset += 1
    trip_participant.date_preferences << date_pref
  end
  
  trip_participants
end

def seed_participant_scores(trip)
  trip_participants = trip.trip_participants
  potential_destinations = trip.potential_destinations

  trip_participants.each do |trip_participant|
    potential_destinations.shuffle.each_with_index do |potential_destination, i|
      score = ParticipantScore.new(
        position: i + 1,
        score: 20 / (i + 1),
        veto: false,
        trip_participant: trip_participant,
        potential_destination: potential_destination
      )
      score.save!
      p "#{trip_participant.user.name} rates #{potential_destination.city.name} position: #{i + 1}"
    end
    trip_participant.scoring_complete = true
    trip_participant.save
  end

  participant_score = ParticipantScore.last
  participant_score.veto = true
  participant_score.save
end

CLOUDINARY_URLS = [
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012739/p2_london_yk2ew1.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012739/p1_beach_gnuuma.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012712/p10_street_barcelona_z2lyve.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012711/p11_tropical_brk2oc.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012711/p9_square_c8bptu.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012710/p4_gate_berlin_v6bcvn.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012710/p6_countryside_lwpc9k.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012710/p7_coast_lnw0qg.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012710/p8_city_bm286f.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012710/p5_dessert_trngk9.jpg",
  "https://res.cloudinary.com/dr4pzn94d/image/upload/v1615012710/p3_houses_dutch_edtg7m.jpg"
]

def attach_random_photos(replace_existing: false)
  # Do something later
  puts "Adding random photos to cities ..."
  i = 0
  cities = City.all
  cities.each do |c|
    next if c.photo.attached? && !replace_existing

    c.photo.purge if c.photo.attached?
    i += 1
    url = CLOUDINARY_URLS.sample
    file = URI.open(url)
    filename = url.match(/[\w-]+\.jpg$/)
    c.photo.attach(io: file, filename: filename)
    puts "#{i}. #{c.name} got #{filename} photo"
  end
end

def delete_photos
  cities = City.all
  cities.each do |c|
    if c.photo.attached?
      c.photo.purge
      puts "Deleted photo for #{c.name}"
    end
  end
end

ParticipantScore.delete_all
PotentialDestination.delete_all
DatePreference.delete_all
TripParticipant.delete_all
Trip.delete_all
TripEstimate.delete_all
User.delete_all
City.delete_all

if ENV["basic"] || ENV["simple"]
  basic_cities
else
  load_city_airports
end

create_users
create_trip_estimates

trip = seed_trip("Away with friends")
seed_potential_destinations(trip)
seed_participant_scores(trip)

# There is now a batch (sidekiq) job that adds photos called AddPhotosJob. So we don't need to do the following.
# delete_photos
# attach_random_photos
