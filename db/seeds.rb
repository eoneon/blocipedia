# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

5.times do
  user = User.create!(
    email:    Faker::Internet.email,
    username: Faker::Name.name,
    password: Faker::Internet.password
    )

    5.times do
      user.wikis.create!(
        title: Faker::Lorem.word,
        body: Faker::Lorem.paragraph
      )
    end
end
users = User.all

puts "Seed finished"
puts "#{User.count} users created"
