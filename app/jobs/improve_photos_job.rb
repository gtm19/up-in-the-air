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
    "https://res.cloudinary.com/dr4pzn94d/image/upload/v1616847040/alpe-unsplash_zwwfd0.jpg",
    "https://res.cloudinary.com/dr4pzn94d/image/upload/v1616847191/paris-unsplash_1_tqb7p3.jpg",
    "https://res.cloudinary.com/dr4pzn94d/image/upload/v1616847046/lisbon-unsplash_iikklf.jpg",
    "https://res.cloudinary.com/dr4pzn94d/image/upload/v1616847048/madrid-unsplash_zg0bzu.jpg"
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
    change_photo(City.find_by(airport_code: "LIS"), 9)
    change_photo(City.find_by(airport_code: "AHZ"), 7)
    change_photo(City.find_by(airport_code: "MAD"), 10)
    change_photo(City.find_by(airport_code: "CDG"), 8)
  end
end
