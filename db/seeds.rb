# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



50.times do
  establishment = Establishment.create({
    name: Faker::Name.name,
    address: Faker::Address.street_name,
    average_rating: Faker::Number.between(1, 5),
    lat: Faker::Address.latitude,
    lng: Faker::Address.longitude,
    id_places: 'ChIJ-ZgW_AB5GZUR-LPwX7gPUNs'
    })

    puts "Criado o estabelecimento #{establishment.id}"

    5.times do
      rating = Rating.create({
        establishment_id: establishment.id,
        black: 2,
        elder: 4,
        woman: 4.5,
        lgbtqia: 3.8,
        rating_date: Faker::Date.between(50.days.ago, Date.today)
        })

        puts "Criado a avaliação #{rating.id}"
      end
    end
