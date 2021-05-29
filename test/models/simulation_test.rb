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

    describe 'Test default values applied by quick simulation' do
      describe '#house_notarial_fees_percentage' do
        it 'returns a default value of 8%' do
          result = simulation.house_notarial_fees_percentage
          expect(result).to eq(0.08)
        end
      end

      describe '#house_tenant_charges_percentage' do
        it 'returns a default value of 80%' do
          result = simulation.house_tenant_charges_percentage
          expect(result).to eq(0.8)
        end
      end

      describe '#credit_loan_interest_percentage_per_year' do
        it 'returns a default value of 1% per year' do
          result = simulation.credit_loan_interest_percentage_per_year
          expect(result).to eq(0.01)
        end
      end

      describe '#credit_loan_insurance_percentage_per_year' do
        it 'returns a default value of 0.30% per year' do
          result = simulation.credit_loan_insurance_percentage_per_year
          expect(result).to eq(0.003)
        end
      end

      describe '#house_insurance_pno_amount_per_year' do
        it 'returns a default value of 100€ per year' do
          result = simulation.house_insurance_pno_amount_per_year
          expect(result).to eq(100)
        end
      end

      describe '#house_insurance_gli_percentage' do
        it 'returns a default value of 3.5%' do
          result = simulation.house_insurance_gli_percentage
          expect(result).to eq(0.035)
        end
      end
    end

    describe '#house_notarial_fees_amount' do
      it 'returns a positive number' do
        result = simulation.house_notarial_fees_amount
        expect(result).to be >= 0
      end
    end
  end
end
