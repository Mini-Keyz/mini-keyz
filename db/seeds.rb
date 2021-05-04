# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

##########################################################################
# Cleaning process

puts '//////////////////////////////////////////////////////'
puts 'Starting the DB cleaning process'

puts '[1/2] - Cleaning the Simulation DB...'
Simulation.destroy_all

puts '[2/2] - Cleaning the User DB...'
User.destroy_all

puts "~ All DB cleaned up\n"
puts '//////////////////////////////////////////////////////'

##########################################################################
# Creating process

puts '//////////////////////////////////////////////////////'
puts 'Starting the seeding process...'

## - # - ###########################################################################
# User
puts '[1/2] - Seeding the User DB...'

testit1 = User.new({
                     email: 'testit1@ok.com',
                     password: '123456'
                   })
testit1.save

testit2 = User.new({
                     email: 'testit2@ok.com',
                     password: '123456'
                   })
testit2.save

## - # - ###########################################################################
# Simulation
puts '[2/2] - Seeding the Simulation DB...'

simulation1 = Simulation.new({
                               house_city: 'Paris I',
                               user: testit1
                             })
simulation1.save

simulation2 = Simulation.new({
                               house_city: 'Paris II',
                               user: testit1
                             })
simulation2.save

simulation3 = Simulation.new({
                               house_city: 'Paris X',
                               user: testit2
                             })
simulation3.save

simulation4 = Simulation.new({
                               house_city: 'Paris XI',
                               user: testit2
                             })
simulation4.save

puts "
~ All seeds created:
- #{User.all.count} users
- #{Simulation.all.count} simulations
"
puts '//////////////////////////////////////////////////////'
