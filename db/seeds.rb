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
                     password: '123456',
                     first_name: 'Testintin',
                     last_name: 'EtMilou'
                   })
testit1.skip_confirmation!
testit1.save!

testit2 = User.new({
                     email: 'testit2@ok.com',
                     password: '123456',
                     first_name: 'TestHaddock',
                     last_name: 'Mille Milliards de Mille Sabords'
                   })
testit2.skip_confirmation!
testit2.save!

## - # - ###########################################################################
# Simulation
puts '[2/2] - Seeding the Simulation DB...'

simulation1 = Simulation.new({
                               house_city: 'Paris I',
                               house_price_bought_amount: 200_000,
                               house_first_works_amount: 10_000,
                               house_total_charges_amount_per_year: 2_000,
                               house_tenant_charges_percentage: 0.8,
                               house_property_tax_amount_per_year: 5_000,
                               house_insurance_pno_amount_per_year: 100,
                               house_insurance_gli_percentage: 0.035,
                               house_rent_amount_per_month: 800,
                               house_property_management_cost_percentage: 0.0,
                               credit_loan_amount: 200_000,
                               credit_loan_duration: 20,
                               credit_loan_interest_percentage_per_year: 0.01,
                               credit_loan_insurance_percentage_per_year: 0.003,
                               fiscal_status: 'Vide',
                               fiscal_regimen: 'Forfait',
                               fiscal_revenues_p1: 50_000,
                               fiscal_revenues_p2: 45_000,
                               #  fiscal_nb_parts: 2,
                               fiscal_nb_dependent_children: 0,
                               fiscal_nb_alternate_custody_children: 0,
                               user: testit1
                             })
simulation1.save

simulation2 = Simulation.new({
                               house_city: 'Paris II',
                               house_price_bought_amount: 300_000,
                               house_first_works_amount: 10_000,
                               house_total_charges_amount_per_year: 2_000,
                               house_tenant_charges_percentage: 0.8,
                               house_property_tax_amount_per_year: 5_000,
                               house_insurance_pno_amount_per_year: 100,
                               house_insurance_gli_percentage: 0.035,
                               house_rent_amount_per_month: 800,
                               house_property_management_cost_percentage: 0.08,
                               credit_loan_amount: 200_000,
                               credit_loan_duration: 20,
                               credit_loan_interest_percentage_per_year: 0.01,
                               credit_loan_insurance_percentage_per_year: 0.003,
                               fiscal_status: 'Vide',
                               fiscal_regimen: 'Réel',
                               fiscal_revenues_p1: 50_000,
                               fiscal_revenues_p2: 45_000,
                               #  fiscal_nb_parts: 3,
                               fiscal_nb_dependent_children: 2,
                               fiscal_nb_alternate_custody_children: 0,
                               user: testit1
                             })
simulation2.save

simulation3 = Simulation.new({
                               house_city: 'Paris X',
                               house_price_bought_amount: 500_000,
                               house_first_works_amount: 10_000,
                               house_total_charges_amount_per_year: 2_000,
                               house_tenant_charges_percentage: 0.8,
                               house_property_tax_amount_per_year: 5_000,
                               house_insurance_pno_amount_per_year: 100,
                               house_insurance_gli_percentage: 0.035,
                               house_rent_amount_per_month: 800,
                               house_property_management_cost_percentage: 0.08,
                               credit_loan_amount: 200_000,
                               credit_loan_duration: 20,
                               credit_loan_interest_percentage_per_year: 0.01,
                               credit_loan_insurance_percentage_per_year: 0.003,
                               fiscal_status: 'Vide',
                               fiscal_regimen: 'Forfait',
                               fiscal_revenues_p1: 50_000,
                               fiscal_revenues_p2: 45_000,
                               #  fiscal_nb_parts: 4,
                               fiscal_nb_dependent_children: 3,
                               fiscal_nb_alternate_custody_children: 0,
                               user: testit2
                             })
simulation3.save

simulation4 = Simulation.new({
                               house_city: 'Paris XI',
                               house_price_bought_amount: 600_000,
                               house_first_works_amount: 10_000,
                               house_total_charges_amount_per_year: 2_000,
                               house_tenant_charges_percentage: 0.8,
                               house_property_tax_amount_per_year: 5_000,
                               house_insurance_pno_amount_per_year: 100,
                               house_insurance_gli_percentage: 0.035,
                               house_rent_amount_per_month: 800,
                               house_property_management_cost_percentage: 0.08,
                               credit_loan_amount: 200_000,
                               credit_loan_duration: 20,
                               credit_loan_interest_percentage_per_year: 0.01,
                               credit_loan_insurance_percentage_per_year: 0.003,
                               fiscal_status: 'LMNP',
                               fiscal_regimen: 'Forfait',
                               fiscal_revenues_p1: 50_000,
                               #  fiscal_nb_parts: 1.5,
                               fiscal_nb_dependent_children: 1,
                               fiscal_nb_alternate_custody_children: 0,
                               user: testit2
                             })
simulation4.save

puts "
~ All seeds created:
- #{User.all.count} users
- #{Simulation.all.count} simulations
"
puts '//////////////////////////////////////////////////////'
