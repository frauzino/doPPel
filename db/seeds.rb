require "faker"

photos = [
  "beret.avif",
  "black_hoodie.avif",
  "coiffed.avif",
  "crazy_hair.avif",
  "grey_beard.avif",
  "hacker.avif",
  "nose_ring.avif",
  "shawl_neck.avif",
  "white_teeth.avif",
  "blonde_profile.avif",
  "blue_tint.avif",
  "business.avif",
  "cool_hair.avif",
  "curly_hair.avif",
  "denim.avif",
  "earrings.avif",
  "green_hair.avif",
  "horizontal_stripes.avif",
  "pale_profile.avif",
  "red_sweater.avif",
  "striped_shirt.avif"
]

places = [
  "3463 Rue Sainte-Famille, Montréal",
  "3680 Jeanne-Mance St, Montreal",
  "3685 Aylmer St, Montreal",
  "4102 Rue Clark, Montréal",
  "953 Napoleon St, Montreal",
  "4416 Rue Berri, Montréal",
  "4766 Brebeuf St, Montreal",
  "5187 St Andre St, Montreal",
  "80 St Viateur St. E, Montreal",
  "6580 Casgrain Ave, Montreal",
  "6970 Av. Wiseman, Montréal",
  "21 Av. Maplewood, Outremont",
  "6452 Rue Lemay, Montréal",
  "5678 Rue de Marseille, Montreal",
  "2653 Rue Du Quesne, Montréal",
  "1926 Av. Émile Legrand, Montréal",
  "4299 Rue de Rouen, Montréal",
  "2161 Av. de la Salle, Montréal",
  "2535 Rue Davidson, Montréal",
  "1908 Rue D'Iberville, Montréal",
  "1632 Rue Dorion, Montréal",
  "2210 Visitation St, Montreal",
  "4376 Drolet St, Montreal",
  "1050 Rue Sainte-Elisabeth, Montreal"
]

puts "cleaning the DB of users and doppelgangers..."
Doppelganger.destroy_all
User.destroy_all
puts "DB is clean!"

puts "making static account Tommy Jensen email: a@a.a password: secret"

User.create(
  email: "a@a.a",
  password: "secret",
  first_name: "Tommy",
  last_name: "Jensen"
)

puts "Static account made"
puts "Making 24 random users"

24.times do User.create(
  email: "#{Faker::Games::Pokemon.name}@doppel.com",
  password: "secret",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)
  puts "made user #{User.last.first_name} #{User.last.last_name}"
end

# def build_address
#   num = rand(10..100)
#   street = %w[Papineau Laurier Victoria King Queen].sample
#   city = %w[Montreal Toronto Ottawa].sample
#   return num.to_s + " " + street + ", " + city
# end

puts "making 24 doppelgangers, one for each user"

User.all.each do |user|
  Doppelganger.create(
    name: "#{user.first_name} #{user.last_name}",
    age: rand(21..100),
    gender: rand(1..3),
    address: places.sample,
    rate: rand(20..500),
    bio: Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote,
    user: user,
    seed_photo: photos.sample
  )
  puts "made doppelganger for #{user.first_name}"
end

# 20.times do Booking.new(
#   start_date: Faker::Date.between(from: Date.today, to: 1.year_from_now)
#   end_date: Faker::Date.between(from: start_date, to: (start_date + rand(0..7))
#   address: Faker::Address.street_address
#   status: rand(0..2)
#   doppelganger_id:
#   user_id:
# )

puts "24 fake doppelgangers created, **not all with valid geocodes"
# puts "20 fake bookings created."
