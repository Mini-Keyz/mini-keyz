require 'rails_helper'

RSpec.describe Simulation, type: :model do
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
                     fiscal_nb_dependent_children: 2,
                     fiscal_nb_alternate_custody_children: 1
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
                     fiscal_nb_dependent_children: 3,
                     fiscal_nb_alternate_custody_children: 0
                   })
  end

  let(:simulation_strasbourg) do
    Simulation.new({
                     house_city: 'Bordeaux',
                     house_price_bought_amount: 300_000,
                     house_first_works_amount: 50_000,
                     house_total_charges_amount_per_year: 2000,
                     house_property_tax_amount_per_year: 1500,
                     house_rent_amount_per_month: 1200,
                     house_property_management_cost_percentage: 0.08,
                     credit_loan_amount: 200_000,
                     credit_loan_duration: 10,
                     fiscal_status: 'LMNP',
                     fiscal_regimen: 'Forfait',
                     fiscal_revenues_p1: 50_000,
                     fiscal_nb_dependent_children: 0,
                     fiscal_nb_alternate_custody_children: 2
                   })
  end

  #-----------------------------------------------------------------------#
  # Validations
  describe 'Validations' do
    describe '#house_city' do
      it { should validate_presence_of(:house_city) }
    end

    describe '#house_price_bought_amount' do
      it { should validate_presence_of(:house_price_bought_amount) }
      it { should validate_numericality_of(:house_price_bought_amount).only_integer }
      it { should validate_numericality_of(:house_price_bought_amount).is_greater_than_or_equal_to(0) }
    end

    describe '#house_first_works_amount' do
      it 'is expected to validate that :house_first_works_amount allows blank input' do
        record = Simulation.new
        record.house_first_works_amount = '' # invalid state
        record.validate
        expect(record.errors[:house_first_works_amount]).to_not include('doit être rempli(e)') # check for presence of error

        record.house_first_works_amount = 10_000 # valid state
        record.validate
        expect(record.errors[:house_first_works_amount]).to_not include('doit être rempli(e)') # check for absence of error
      end
      it { should validate_numericality_of(:house_first_works_amount).only_integer }
      it { should validate_numericality_of(:house_first_works_amount).is_greater_than_or_equal_to(0) }
    end

    describe '#house_total_charges_amount_per_year' do
      it { should validate_presence_of(:house_total_charges_amount_per_year) }
      it { should validate_numericality_of(:house_total_charges_amount_per_year).only_integer }
      it { should validate_numericality_of(:house_total_charges_amount_per_year).is_greater_than_or_equal_to(0) }
    end

    describe '#house_property_tax_amount_per_year' do
      it { should validate_presence_of(:house_property_tax_amount_per_year) }
      it { should validate_numericality_of(:house_property_tax_amount_per_year).only_integer }
      it { should validate_numericality_of(:house_property_tax_amount_per_year).is_greater_than_or_equal_to(0) }
    end

    describe '#house_rent_amount_per_month' do
      it { should validate_presence_of(:house_rent_amount_per_month) }
      it { should validate_numericality_of(:house_rent_amount_per_month).only_integer }
      it { should validate_numericality_of(:house_rent_amount_per_month).is_greater_than_or_equal_to(0) }
    end

    describe '#house_property_management_cost_percentage' do
      it { should validate_presence_of(:house_property_management_cost_percentage) }
      it { should validate_numericality_of(:house_property_management_cost_percentage) }

      it 'validates only between [0,1]' do
        record = Simulation.new
        record.house_property_management_cost_percentage = -5 # invalid state
        record.validate
        expect(record.errors[:house_property_management_cost_percentage]).to include('doit être supérieur ou égal à 0') # check for presence of error

        record = Simulation.new
        record.house_property_management_cost_percentage = 2 # invalid state
        record.validate
        expect(record.errors[:house_property_management_cost_percentage]).to include('doit être inférieur ou égal à 1') # check for presence of error

        record.house_property_management_cost_percentage = 0.05 # valid state
        record.validate
        expect(record.errors[:house_property_management_cost_percentage]).to_not include('doit être supérieur ou égal à 0') # check for absence of error

        record.house_property_management_cost_percentage = 0 # valid state
        record.validate
        expect(record.errors[:house_property_management_cost_percentage]).to_not include('doit être supérieur ou égal à 0') # check for absence of error

        record.house_property_management_cost_percentage = 1 # valid state
        record.validate
        expect(record.errors[:house_property_management_cost_percentage]).to_not include('doit être inférieur ou égal à 1') # check for absence of error
      end
    end

    describe '#credit_loan_amount' do
      it { should validate_presence_of(:credit_loan_amount) }
      it { should validate_numericality_of(:credit_loan_amount).only_integer }
      it { should validate_numericality_of(:credit_loan_amount).is_greater_than_or_equal_to(0) }
    end

    describe '#credit_loan_duration' do
      it { should validate_presence_of(:credit_loan_duration) }
      it { should validate_numericality_of(:credit_loan_duration).only_integer }
      it { should validate_numericality_of(:credit_loan_duration).is_greater_than_or_equal_to(0) }
    end

    describe '#fiscal_status' do
      it { should validate_presence_of(:fiscal_status) }

      it 'validates inclusion in fiscal status available ' do
        record = Simulation.new
        record.fiscal_status = 'Fiscal status not implemented' # invalid state
        record.validate
        expect(record.errors[:fiscal_status]).to include("n'est pas inclus(e) dans la liste") # check for presence of error

        record.fiscal_status = 'Pinel' # valid state
        record.validate
        expect(record.errors[:fiscal_status]).to_not include("n'est pas inclus(e) dans la liste") # check for absence of error
      end
    end

    describe '#fiscal_regimen' do
      it { should validate_presence_of(:fiscal_regimen) }

      it 'validates inclusion in fiscal regimen available ' do
        record = Simulation.new
        record.fiscal_regimen = 'Fiscal status not implemented' # invalid state
        record.validate
        expect(record.errors[:fiscal_regimen]).to include("n'est pas inclus(e) dans la liste") # check for presence of error

        record.fiscal_regimen = 'Forfait' # valid state
        record.validate
        expect(record.errors[:fiscal_regimen]).to_not include("n'est pas inclus(e) dans la liste") # check for absence of error
      end
    end

    describe '#fiscal_revenues_p1' do
      it { should validate_presence_of(:fiscal_revenues_p1) }
      it { should validate_numericality_of(:fiscal_revenues_p1).only_integer }
      it { should validate_numericality_of(:fiscal_revenues_p1).is_greater_than_or_equal_to(0) }
    end

    describe '#fiscal_revenues_p2' do
      it 'allows to be blank' do
        record = Simulation.new
        record.fiscal_revenues_p2 = '' # invalid state
        record.validate
        expect(record.errors[:fiscal_revenues_p2]).to_not include('doit être rempli(e)') # check for presence of error

        record.fiscal_revenues_p2 = 55_000 # valid state
        record.validate
        expect(record.errors[:fiscal_revenues_p2]).to_not include('doit être rempli(e)') # check for absence of error
      end

      it { should validate_numericality_of(:fiscal_revenues_p2).only_integer }
      it { should validate_numericality_of(:fiscal_revenues_p2).is_greater_than_or_equal_to(0) }
    end

    describe '#fiscal_nb_dependent_children' do
      it { should validate_presence_of(:fiscal_nb_dependent_children) }
      it { should validate_numericality_of(:fiscal_nb_dependent_children).only_integer }
      it { should validate_numericality_of(:fiscal_nb_dependent_children).is_greater_than_or_equal_to(0) }
    end

    describe '#fiscal_nb_alternate_custody_children' do
      it { should validate_presence_of(:fiscal_nb_alternate_custody_children) }
      it { should validate_numericality_of(:fiscal_nb_alternate_custody_children).only_integer }
      it { should validate_numericality_of(:fiscal_nb_alternate_custody_children).is_greater_than_or_equal_to(0) }
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

    describe '#house_insurance_gli_amount_per_month' do
      it 'returns the gli cost per month' do
        result_lyon = simulation_lyon.house_insurance_gli_amount_per_month
        result_bordeaux = simulation_bordeaux.house_insurance_gli_amount_per_month
        expect(result_lyon).to be_within(0.1).of(87.5)
        expect(result_bordeaux).to be_within(0.1).of(15.75)
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

    ## PNO
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
    ## General
    describe '#credit_loan_duration_in_months' do
      it 'returns the duration of the loan in months' do
        result_lyon = simulation_lyon.credit_loan_duration_in_months
        result_bordeaux = simulation_bordeaux.credit_loan_duration_in_months
        expect(result_lyon).to eq(240)
        expect(result_bordeaux).to eq(240)
      end
    end

    describe '#credit_loan_payment_amount_per_month' do
      it 'returns the payment (principal + interets) made per month to the bank' do
        result_lyon = simulation_lyon.credit_loan_payment_amount_per_month
        result_bordeaux = simulation_bordeaux.credit_loan_payment_amount_per_month
        expect(result_lyon).to be_within(0.01).of(2529.42)
        expect(result_bordeaux).to be_within(0.01).of(459.89)
      end
    end

    ## Interests
    describe '#credit_loan_interest_percentage_per_year' do
      it 'returns a default value of 1% per year' do
        result_lyon = simulation_lyon.credit_loan_interest_percentage_per_year
        expect(result_lyon).to eq(0.01)
      end
    end

    describe '#credit_loan_interest_rate_per_month' do
      it 'returns the credit loan interest as a credit loan interest per month' do
        result_lyon = simulation_lyon.credit_loan_interest_rate_per_month
        expect(result_lyon).to be_within(0.00001).of(0.00083)
      end
    end

    describe '#credit_loan_interest_cost_for_month(payment_period)' do
      it 'returns the loan interest cost for a given month' do
        result_lyon = simulation_lyon.credit_loan_interest_cost_for_month(121)
        result_bordeaux = simulation_bordeaux.credit_loan_interest_cost_for_month(13)
        expect(result_lyon).to be_within(0.01).of(240.61)
        expect(result_bordeaux).to be_within(0.01).of(79.55)
      end
    end

    describe '#credit_loan_cumulative_interests_paid_for_year(payment_period)' do
      it 'returns the sum of interest costs for a given year (years are not 0 based!)' do
        result_lyon = simulation_lyon.credit_loan_cumulative_interests_paid_for_year(5)
        result_bordeaux = simulation_bordeaux.credit_loan_cumulative_interests_paid_for_year(20)
        expect(result_lyon).to be_within(0.01).of(4367.27)
        expect(result_bordeaux).to be_within(0.01).of(29.78)
      end
    end

    describe '#credit_loan_cumulative_interests_paid_for_year_two' do
      it 'returns the sum of interest costs for a the second year of the loan' do
        result_lyon = simulation_lyon.credit_loan_cumulative_interests_paid_for_year_two
        result_bordeaux = simulation_bordeaux.credit_loan_cumulative_interests_paid_for_year_two
        expect(result_lyon).to be_within(0.01).of(5134.95)
        expect(result_bordeaux).to be_within(0.01).of(933.63)
      end
    end

    describe '#credit_loan_cumulative_interests_paid_since_beginning_for_month(payment_period)' do
      it 'returns the sum of interest costs paid since the beginning of the loan for a given month' do
        result_lyon = simulation_lyon.credit_loan_cumulative_interests_paid_since_beginning_for_month(150)
        result_bordeaux = simulation_bordeaux.credit_loan_cumulative_interests_paid_since_beginning_for_month(25)
        expect(result_lyon).to be_within(0.01).of(48_645.22)
        expect(result_bordeaux).to be_within(0.01).of(1988.59)
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

    ## Principal
    describe '#credit_loan_principal_repayment_for_month(payment_period)' do
      it 'returns the loan principal repayment for a given month' do
        result_lyon = simulation_lyon.credit_loan_principal_repayment_for_month(200)
        result_bordeaux = simulation_bordeaux.credit_loan_principal_repayment_for_month(125)
        expect(result_lyon).to be_within(0.01).of(2444.49)
        expect(result_bordeaux).to be_within(0.01).of(417.54)
      end
    end

    describe '#credit_loan_cumulative_principal_paid_since_beginning_for_month(payment_period)' do
      it 'returns the sum of loan principal repayments since the beginning of the loan for a given month' do
        result_lyon = simulation_lyon.credit_loan_cumulative_principal_paid_since_beginning_for_month(100)
        result_bordeaux = simulation_bordeaux.credit_loan_cumulative_principal_paid_since_beginning_for_month(180)
        expect(result_lyon).to be_within(0.01).of(215_889.10)
        expect(result_bordeaux).to be_within(0.01).of(73_095.76)
      end
    end

    describe '#credit_loan_remaining_principal_to_pay_for_month(payment_period)' do
      it 'returns the remaining loan principal to pay for a given month' do
        result_lyon = simulation_lyon.credit_loan_remaining_principal_to_pay_for_month(100)
        result_bordeaux = simulation_bordeaux.credit_loan_remaining_principal_to_pay_for_month(180)
        expect(result_lyon).to be_within(0.01).of(334_110.9)
        expect(result_bordeaux).to be_within(0.01).of(26_904.24)
      end
    end

    ## Insurance
    describe '#credit_loan_insurance_percentage_per_year' do
      it 'returns a default value of 0.30% per year' do
        result_lyon = simulation_lyon.credit_loan_insurance_percentage_per_year
        expect(result_lyon).to eq(0.003)
      end
    end

    describe '#credit_loan_insurance_percentage_per_month' do
      it 'returns the loan insurance percentage as a loan insurance percentage per month' do
        result_lyon = simulation_lyon.credit_loan_insurance_percentage_per_month
        expect(result_lyon).to eq(0.00025)
      end
    end

    describe '#credit_loan_insurance_amount_per_month' do
      it 'returns the loan insurance cost per month' do
        result_lyon = simulation_lyon.credit_loan_insurance_amount_per_month
        result_bordeaux = simulation_bordeaux.credit_loan_insurance_amount_per_month
        expect(result_lyon).to be_within(0.01).of(137.5)
        expect(result_bordeaux).to be_within(0.01).of(25)
      end
    end

    describe '#credit_loan_insurance_amount_per_year' do
      it 'returns the loan insurance cost per year' do
        result_lyon = simulation_lyon.credit_loan_insurance_amount_per_year
        result_bordeaux = simulation_bordeaux.credit_loan_insurance_amount_per_year
        expect(result_lyon).to be_within(0.01).of(1650)
        expect(result_bordeaux).to be_within(0.01).of(300)
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
  # Fiscal related formulas
  describe 'Fiscal related formulas' do
    describe '#fiscal_marital_status' do
      it 'returns "Marié / Pacsé" if there is a revenues inputed for p2' do
        result_lyon = simulation_lyon.fiscal_marital_status
        result_bordeaux = simulation_bordeaux.fiscal_marital_status
        expect(result_lyon).to eq('Marié / Pacsé')
        expect(result_bordeaux).to eq('Marié / Pacsé')
      end

      it 'returns "Célibataire" if there is no revenues inputed for p2' do
        result_strasbourg = simulation_strasbourg.fiscal_marital_status
        expect(result_strasbourg).to eq('Célibataire')
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
