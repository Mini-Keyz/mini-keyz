require './test/test_helper'

class SimulationTest < ActiveSupport::TestCase
  describe 'Simulation' do
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

    describe '#house_city' do
      it 'validates presence of' do
        record = Simulation.new
        record.house_city = '' # invalid state
        record.validate
        expect(record.errors[:house_city]).to include("can't be blank") # check for presence of error

        record.house_city = 'Lyon' # valid state
        record.validate
        expect(record.errors[:house_city]).to_not include("can't be blank") # check for absence of error
      end
    end

    #-----------------------------------------------------------------------#
    # House related formulas
    describe 'House related formulas' do
      ## Notarial fees
      describe '#house_notarial_fees_percentage' do
        it 'returns a default value of 8%' do
          result_lyon = simulation_lyon.house_notarial_fees_percentage
          expect(result_lyon).to eq(0.08)
        end
      end

      describe '#house_notarial_fees_amount' do
        it 'returns an amount equal to 8% of price bought' do
          result_lyon = simulation_lyon.house_notarial_fees_amount
          result_bordeaux = simulation_bordeaux.house_notarial_fees_amount
          expect(result_lyon).to eq(40_000)
          expect(result_bordeaux).to eq(8000)
        end
      end

      ## Charges
      describe '#house_tenant_charges_percentage' do
        it 'returns a default value of 80%' do
          result_lyon = simulation_lyon.house_tenant_charges_percentage
          expect(result_lyon).to eq(0.8)
        end
      end

      describe '#house_tenant_charges_amount_per_year' do
        it 'returns an amount equal to 80% of house_total_charges_amount_per_year' do
          result_lyon = simulation_lyon.house_tenant_charges_amount_per_year
          result_bordeaux = simulation_bordeaux.house_tenant_charges_amount_per_year
          expect(result_lyon).to eq(2200)
          expect(result_bordeaux).to eq(400)
        end
      end

      describe '#house_landlord_charges_amount_per_year' do
        it 'returns an amount equal to 20% of house_total_charges_amount_per_year' do
          result_lyon = simulation_lyon.house_landlord_charges_amount_per_year
          result_bordeaux = simulation_bordeaux.house_landlord_charges_amount_per_year
          expect(result_lyon).to eq(550)
          expect(result_bordeaux).to eq(100)
        end
      end

      ## Rent
      describe '#house_rent_amount_per_year' do
        it 'returns the rent revenue generated' do
          result_lyon = simulation_lyon.house_rent_amount_per_year
          result_bordeaux = simulation_bordeaux.house_rent_amount_per_year
          expect(result_lyon).to eq(30_000)
          expect(result_bordeaux).to eq(5400)
        end
      end

      ## Property management
      describe '#house_property_management_amount_per_year' do
        it 'when property management is set to false, returns an amount equal to 0' do
          result_lyon = simulation_lyon.house_property_management_amount_per_year
          expect(result_lyon).to eq(0)
        end

        it 'when property management is set to true, returns an amount equal to 8% of rent amount per year' do
          result_bordeaux = simulation_bordeaux.house_property_management_amount_per_year
          expect(result_bordeaux).to eq(432)
        end
      end

      ## GLI
      describe '#house_insurance_gli_percentage' do
        it 'returns a default value of 3.5%' do
          result_lyon = simulation_lyon.house_insurance_gli_percentage
          expect(result_lyon).to eq(0.035)
        end
      end

      describe '#house_insurance_gli_amount_per_year' do
        it 'returns the gli cost per year' do
          result_lyon = simulation_lyon.house_insurance_gli_amount_per_year
          result_bordeaux = simulation_bordeaux.house_insurance_gli_amount_per_year
          expect(result_lyon).to be_within(0.1).of(1050)
          expect(result_bordeaux).to be_within(0.1).of(189)
        end
      end

      describe '#house_insurance_pno_amount_per_year' do
        it 'returns a default value of 100€ per year' do
          result_lyon = simulation_lyon.house_insurance_pno_amount_per_year
          expect(result_lyon).to eq(100)
        end
      end
    end

    #-----------------------------------------------------------------------#
    # Credit related formulas
    describe 'Credit related formulas' do
      ## Interests
      describe '#credit_loan_interest_percentage_per_year' do
        it 'returns a default value of 1% per year' do
          result_lyon = simulation_lyon.credit_loan_interest_percentage_per_year
          expect(result_lyon).to eq(0.01)
        end
      end

      describe '#credit_loan_interest_total_amount' do
        it 'returns the loan interest total cost' do
          result_lyon = simulation_lyon.credit_loan_interest_total_amount
          result_bordeaux = simulation_bordeaux.credit_loan_interest_total_amount
          expect(result_lyon).to be_within(0.01).of(57_060.48)
          expect(result_bordeaux).to be_within(0.01).of(10_374.63)
        end
      end

      ## Insurance
      describe '#credit_loan_insurance_percentage_per_year' do
        it 'returns a default value of 0.30% per year' do
          result_lyon = simulation_lyon.credit_loan_insurance_percentage_per_year
          expect(result_lyon).to eq(0.003)
        end
      end

      describe '#credit_loan_insurance_total_amount' do
        it 'returns the loan insurance total cost' do
          result_lyon = simulation_lyon.credit_loan_insurance_total_amount
          result_bordeaux = simulation_bordeaux.credit_loan_insurance_total_amount
          expect(result_lyon).to be_within(0.01).of(33_000)
          expect(result_bordeaux).to be_within(0.01).of(6_000)
        end
      end
    end

    #-----------------------------------------------------------------------#
    # Profitability formulas
    describe 'Profitability formulas' do
      describe '#global_buying_operation_cost' do
        it 'returns the global buying operation cost' do
          result_lyon = simulation_lyon.global_buying_operation_cost
          result_bordeaux = simulation_bordeaux.global_buying_operation_cost
          expect(result_lyon).to eq(565_000)
          expect(result_bordeaux).to eq(108_000)
        end
      end

      describe '#gross_profitability' do
        it 'returns the gross profitability' do
          result_lyon = simulation_lyon.gross_profitability
          result_bordeaux = simulation_bordeaux.gross_profitability
          expect(result_lyon).to be_within(0.01).of(5.31)
          expect(result_bordeaux).to be_within(0.01).of(5.00)
        end
      end

      describe '#net_profitability' do
        it 'returns the net profitability' do
          result_lyon = simulation_lyon.net_profitability
          result_bordeaux = simulation_bordeaux.net_profitability
          expect(result_lyon).to be_within(0.01).of(3.68)
          expect(result_bordeaux).to be_within(0.01).of(3.19)
        end
      end
    end
  end
end
