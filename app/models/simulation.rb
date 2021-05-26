class Simulation < ApplicationRecord
  belongs_to :user

  validates :house_city, presence: true
  validates :house_price_bought_amount, presence: true, numericality: { only_integer: true }
  validates :house_first_works_amount, allow_blank: true, numericality: { only_integer: true }
  validates :house_total_charges_amount_per_year, presence: true, numericality: { only_integer: true }
  validates :house_property_tax_amount_per_year, presence: true, numericality: { only_integer: true }
  validates :house_rent_amount_per_month, presence: true, numericality: { only_integer: true }
  validates :house_property_management_cost_percentage, presence: true
  validates :credit_loan_amount, presence: true, numericality: { only_integer: true }
  validates :credit_loan_duration, presence: true, numericality: { only_integer: true }
  validates :fiscal_status, presence: true
  validates :fiscal_regimen, presence: true
  validates :fiscal_revenues_p1, presence: true, numericality: { only_integer: true }
  validates :fiscal_revenues_p2, allow_blank: true, numericality: { only_integer: true }
  validates :fiscal_nb_parts, presence: true

  include(CreditFormulas)
  include(IncomeTaxesFormulas)

  HOUSE_STANDARD_NOTARIAL_FEES_PERCENTAGE = 0.08
  HOUSE_STANDARD_TENANT_CHARGES_PERCENTAGE = 0.8
  HOUSE_STANDARD_INSURANCE_PNO_AMOUNT_PER_YEAR = 100
  HOUSE_STANDARD_INSURANCE_GLI_PERCENTAGE = 0.035
  CREDIT_STANDARD_LOAN_INTEREST_PERCENTAGE_PER_YEAR = 0.01
  CREDIT_STANDARD_LOAN_INSURANCE_PERCENTAGE_PER_YEAR = 0.003

  def initialize(args)
    super
    self.house_notarial_fees_percentage = HOUSE_STANDARD_NOTARIAL_FEES_PERCENTAGE unless house_notarial_fees_percentage
    unless house_tenant_charges_percentage
      self.house_tenant_charges_percentage = HOUSE_STANDARD_TENANT_CHARGES_PERCENTAGE
    end
    unless credit_loan_interest_percentage_per_year
      self.credit_loan_interest_percentage_per_year = CREDIT_STANDARD_LOAN_INTEREST_PERCENTAGE_PER_YEAR
    end
    unless credit_loan_insurance_percentage_per_year
      self.credit_loan_insurance_percentage_per_year = CREDIT_STANDARD_LOAN_INSURANCE_PERCENTAGE_PER_YEAR
    end
    unless house_insurance_pno_amount_per_year
      self.house_insurance_pno_amount_per_year = HOUSE_STANDARD_INSURANCE_PNO_AMOUNT_PER_YEAR
    end
    self.house_insurance_gli_percentage = HOUSE_STANDARD_INSURANCE_GLI_PERCENTAGE unless house_insurance_gli_percentage
  end

  # Remember to put conditional if tenant charges amount is specified
  def house_notarial_fees_amount
    house_price_bought_amount * house_notarial_fees_percentage
  end

  def house_property_management_amount_per_year
    house_rent_amount_per_year * house_property_management_cost_percentage
  end

  def house_tenant_charges_amount_per_year
    house_total_charges_amount_per_year * house_tenant_charges_percentage
  end

  def house_landlord_charges_amount_per_year
    house_total_charges_amount_per_year - house_tenant_charges_amount_per_year
  end

  def gross_profitability
    quotient = house_rent_amount_per_year
    divisor = global_buying_operation_cost

    quotient / divisor * 100
  end

  def net_profitability
    revenues = house_rent_amount_per_year
    expenses = house_tenant_charges_amount_per_year + house_property_tax_amount_per_year + house_insurance_pno_amount_per_year + house_insurance_gli_amount_per_year + house_rent_amount_per_year * house_property_management_cost_percentage
    divisor = global_buying_operation_cost + credit_loan_interest_total_amount + credit_loan_insurance_total_amount

    (revenues - expenses) / divisor * 100
  end

  def net_after_taxes_profitability
    6.6
  end

  def global_buying_operation_cost
    house_price_bought_amount * (1 + house_notarial_fees_percentage) + house_first_works_amount
  end

  def created_for
    returned_string = TimeDifference.between(created_at, Date.today).humanize
    find_words_only = /\b[^\d\W]+\b/
    returned_string_in_french = returned_string.gsub(find_words_only, time_in_french)
  end

  # Insurance

  def house_insurance_gli_amount_per_month
    house_insurance_gli_percentage * house_rent_amount_per_month
  end

  def house_insurance_gli_amount_per_year
    house_insurance_gli_percentage * house_rent_amount_per_year
  end

  # House

  def house_rent_amount_per_year
    house_rent_amount_per_month * 12
  end

  # Credit cost
  def credit_loan_duration_in_months
    credit_loan_duration * 12
  end

  def credit_loan_interest_rate_per_month
    credit_loan_interest_percentage_per_year / 12
  end

  def credit_loan_payment_amount_per_month
    - pmt(credit_loan_interest_rate_per_month, credit_loan_duration_in_months, credit_loan_amount)
  end

  def credit_loan_interest_cost_for_month(payment_period)
    - ipmt(credit_loan_interest_rate_per_month, payment_period, credit_loan_duration_in_months, credit_loan_amount)
  end

  def credit_loan_principal_repayment_for_month(payment_period)
    - ppmt(credit_loan_interest_rate_per_month, payment_period, credit_loan_duration_in_months, credit_loan_amount)
  end

  def credit_loan_cumulative_principal_paid_for_month(payment_period)
    - cumprinc(credit_loan_interest_rate_per_month, credit_loan_duration_in_months, credit_loan_amount, 1,
               payment_period)
  end

  def credit_loan_cumulative_interests_paid_for_month(payment_period)
    - cumipmt(credit_loan_interest_rate_per_month, credit_loan_duration_in_months, credit_loan_amount, 1,
              payment_period)
  end

  def credit_loan_interest_total_amount
    credit_loan_cumulative_interests_paid_for_month(credit_loan_duration_in_months)
  end

  def credit_loan_remaining_principal_to_pay_for_month(payment_period)
    credit_loan_amount - credit_loan_cumulative_principal_paid_for_month(payment_period)
  end

  # Credit_loan insurance

  def credit_loan_insurance_percentage_per_month
    credit_loan_insurance_percentage_per_year / 12
  end

  def credit_loan_insurance_amount_per_month
    credit_loan_insurance_percentage_per_month * credit_loan_amount
  end

  def credit_loan_insurance_total_amount
    credit_loan_insurance_amount_per_month * credit_loan_duration_in_months
  end

  private

  def time_in_french
    {
      'Year' => 'année',
      'Years' => 'années',
      'Month' => 'mois',
      'Months' => 'mois',
      'Weeks' => 'semaines',
      'Week' => 'semaine',
      'Days' => 'jours',
      'Day' => 'jour',
      'Hours' => 'heures',
      'Hour' => 'heure',
      'Minutes' => 'minutes',
      'Minute' => 'minute',
      'Seconds' => 'secondes',
      'Second' => 'seconde',
      'and' => 'et'
    }
  end
end
