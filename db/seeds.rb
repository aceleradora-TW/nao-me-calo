# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

     Establishment.create(
        name: 'Cavanhas',
        address: Faker::Address.street_name,
        average_rating: Faker::Number.between(1, 5),
        lat: Faker::Address.latitude,
        lng: Faker::Address.longitude,
        id_places: 'ChIJ-ZgW_AB5GZUR-LPwX7gPUNs'
      )


      Establishment.create(
         name: 'Beco 203',
         address: Faker::Address.street_name,
         average_rating: Faker::Number.between(1, 5),
         lat: Faker::Address.latitude,
         lng: Faker::Address.longitude,
         id_places: 'ChIJj2J3iGOCGZUR5XT38N2pANQ'
       )

       Establishment.create(
          name: 'Shopping Iguatemi',
          address: Faker::Address.street_name,
          average_rating: Faker::Number.between(1, 5),
          lat: Faker::Address.latitude,
          lng: Faker::Address.longitude,
          id_places: 'ChIJV9G_oJl3GZURDBaCCfFPGEo'
        )
