require './test/test_helper'

class SimulationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  describe 'Simulation' do
    # A maried couple with 2 children, in a good professional shape is thinking about making an investment in the center of Lyon and rent it to a well-off couple
    subject(:simulation) do
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

    describe '#house_notarial_fees_amount' do
      it 'returns a positive number' do
        result = simulation.house_notarial_fees_amount
        expect(result).to be >= 0
      end
    end
  end
end
