class CityPicturesJob < ApplicationJob
  require 'open-uri'

  queue_as :default

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

  def perform(replace_existing: false)
    # Do something later
    puts "Adding random photos to cities ..."
    i = 0
    cities = City.all
    cities.each do |c|
      next if c.photo_attached? && !replace_existing

      c.photo.purge if c.photo_attached?
      i += 1
      url = CLOUDINARY_URLS.sample
      file = URI.open(url)
      filename = url.match(/[\w-]+\.jpg$/)
      c.photo.attach(io: file, filename: filename)
      puts "#{i}. #{c.name} got #{filename} photo"
    end
  end
end
