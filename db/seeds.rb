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
                               house_price_bought: 200_000,
                               house_first_works: 10_000,
                               house_annual_charges: 2_000,
                               house_tenant_charges_percentage: 0.8,
                               house_property_tax: 5_000,
                               house_insurance_pno_annual_cost: 100,
                               house_insurance_gli_annual_cost: 0.035,
                               house_rent_per_month: 800,
                               house_delegated_maintenance_value: 0.0,
                               credit_amount: 200_000,
                               credit_duration: 20,
                               credit_interest_rate: 0.01,
                               credit_insurance_rate: 0.003,
                               fiscal_status: 'LMNP',
                               fiscal_regimen: 'Forfait',
                               fiscal_revenues_p1: 50_000,
                               fiscal_revenues_p2: 45_000,
                               fiscal_nb_parts: 2,
                               user: testit1
                             })
simulation1.save

simulation2 = Simulation.new({
                               house_city: 'Paris II',
                               house_price_bought: 300_000,
                               house_first_works: 10_000,
                               house_annual_charges: 2_000,
                               house_tenant_charges_percentage: 0.8,
                               house_property_tax: 5_000,
                               house_insurance_pno_annual_cost: 100,
                               house_insurance_gli_annual_cost: 0.035,
                               house_rent_per_month: 800,
                               house_delegated_maintenance_value: 0.08,
                               credit_amount: 200_000,
                               credit_duration: 20,
                               credit_interest_rate: 0.01,
                               credit_insurance_rate: 0.003,
                               fiscal_status: 'LMNP',
                               fiscal_regimen: 'Forfait',
                               fiscal_revenues_p1: 50_000,
                               fiscal_revenues_p2: 45_000,
                               fiscal_nb_parts: 2,
                               user: testit1
                             })
simulation2.save

simulation3 = Simulation.new({
                               house_city: 'Paris X',
                               house_price_bought: 500_000,
                               house_first_works: 10_000,
                               house_annual_charges: 2_000,
                               house_tenant_charges_percentage: 0.8,
                               house_property_tax: 5_000,
                               house_insurance_pno_annual_cost: 100,
                               house_insurance_gli_annual_cost: 0.035,
                               house_rent_per_month: 800,
                               house_delegated_maintenance_value: 0.08,
                               credit_amount: 200_000,
                               credit_duration: 20,
                               credit_interest_rate: 0.01,
                               credit_insurance_rate: 0.003,
                               fiscal_status: 'LMNP',
                               fiscal_regimen: 'Forfait',
                               fiscal_revenues_p1: 50_000,
                               fiscal_revenues_p2: 45_000,
                               fiscal_nb_parts: 2,
                               user: testit2
                             })
simulation3.save

simulation4 = Simulation.new({
                               house_city: 'Paris XI',
                               house_price_bought: 600_000,
                               house_first_works: 10_000,
                               house_annual_charges: 2_000,
                               house_tenant_charges_percentage: 0.8,
                               house_property_tax: 5_000,
                               house_insurance_pno_annual_cost: 100,
                               house_insurance_gli_annual_cost: 0.035,
                               house_rent_per_month: 800,
                               house_delegated_maintenance_value: 0.08,
                               credit_amount: 200_000,
                               credit_duration: 20,
                               credit_interest_rate: 0.01,
                               credit_insurance_rate: 0.003,
                               fiscal_status: 'LMNP',
                               fiscal_regimen: 'Forfait',
                               fiscal_revenues_p1: 50_000,
                               fiscal_revenues_p2: 45_000,
                               fiscal_nb_parts: 2,
                               user: testit2
                             })
simulation4.save

puts "
~ All seeds created:
- #{User.all.count} users
- #{Simulation.all.count} simulations
"
puts '//////////////////////////////////////////////////////'
