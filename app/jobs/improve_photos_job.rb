class ImprovePhotosJob < ApplicationJob
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

  def change_photo(c, index)
    # Do something later
    puts "Fixing photo"
    c.photo.purge if c.photo.attached?
    url = CLOUDINARY_URLS[index]
    file = URI.open(url)
    filename = url.match(/[\w-]+\.jpg$/)
    c.photo.attach(io: file, filename: filename)
    puts "#{c.name} got #{filename} photo"
  end

  def perform
    change_photo(City.find_by(airport_code: "LHR"), 0)
    change_photo(City.find_by(airport_code: "SXF"), 5)
  end

end
