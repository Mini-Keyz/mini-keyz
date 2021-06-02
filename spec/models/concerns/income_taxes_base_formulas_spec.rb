require 'rails_helper'

RSpec.describe IncomeTaxesBaseFormulas do
  let(:simulation_lyon) do
    Simulation.new({
                     house_city: 'Lyon 01',
                     house_price_bought_amount: 500_000,
                     house_first_works_amount: 25_000,
                     house_total_charges_amount_per_year: 2750,
                     house_property_tax_amount_per_year: 2500,
                     house_rent_amount_per_month: 2500,
                     house_property_management_cost_percentage: 0,
                     credit_loan_amount: 550_000,
                     credit_loan_duration: 20,
                     fiscal_status: 'Vide',
                     fiscal_regimen: 'Réel',
                     fiscal_revenues_p1: 75_000,
                     fiscal_revenues_p2: 25_000,
                     fiscal_nb_parts: 3
                   })
  end

  let(:simulation_bordeaux) do
    Simulation.new({
                     house_city: 'Bordeaux',
                     house_price_bought_amount: 100_000,
                     house_first_works_amount: 0,
                     house_total_charges_amount_per_year: 500,
                     house_property_tax_amount_per_year: 300,
                     house_rent_amount_per_month: 450,
                     house_property_management_cost_percentage: 0.08,
                     credit_loan_amount: 100_000,
                     credit_loan_duration: 20,
                     fiscal_status: 'LMNP',
                     fiscal_regimen: 'Réel',
                     fiscal_revenues_p1: 25_000,
                     fiscal_revenues_p2: 35_000,
                     fiscal_nb_parts: 4
                   })
  end

  # describe "#calc_income_tax_amount_per_year" do
  #   it "returns the income tax amont per year" do
  #     result_lyon = IncomeTaxesBaseFormulas.calc_income_tax_amount_per_year()
  #   end
  # end

  describe '#calc_net_taxable_amount' do
    it 'returns the taxable amount (case when no property income)' do
      result_lyon = IncomeTaxesBaseFormulas.calc_net_taxable_amount(simulation_lyon)
      result_bordeaux = IncomeTaxesBaseFormulas.calc_net_taxable_amount(simulation_bordeaux)
      expect(result_lyon).to be_within(1).for
      expect(result_bordeaux).to be_within(1).for
    end
  end
end
