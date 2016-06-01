# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
     Establishment.create(
        name: Faker::Name.name,
        address: Faker::Address.street_name,
        average_rating: Faker::Number.between(1, 5),
        lat: Faker::Address.latitude,
        lng: Faker::Address.longitude,
        id_places: Faker::Number.between(1, 1000)
      )
end
