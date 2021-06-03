class Simulation < ApplicationRecord
  belongs_to :user, optional: true

  validates :house_city, presence: true
  validates :house_price_bought_amount, presence: true,
                                        numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :house_first_works_amount, allow_blank: true,
                                       numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :house_total_charges_amount_per_year, presence: true,
                                                  numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :house_property_tax_amount_per_year, presence: true,
                                                 numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :house_rent_amount_per_month, presence: true,
                                          numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :house_property_management_cost_percentage, presence: true,
                                                        numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :credit_loan_amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :credit_loan_duration, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :fiscal_status, presence: true, inclusion: { in: proc { FISCAL_STATUS_AVAILABLE } }
  validates :fiscal_regimen, presence: true, inclusion: { in: proc { FISCAL_REGIMEN_AVAILABLE } }
  validates :fiscal_revenues_p1, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0  }
  validates :fiscal_revenues_p2, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :fiscal_nb_parts, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fiscal_nb_dependent_children, presence: true,
                                           numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  include(CreditFormulas)
  include(IncomeTaxesFormulas)

  HOUSE_STANDARD_NOTARIAL_FEES_PERCENTAGE = 0.08
  HOUSE_STANDARD_TENANT_CHARGES_PERCENTAGE = 0.8
  HOUSE_STANDARD_INSURANCE_PNO_AMOUNT_PER_YEAR = 100
  HOUSE_STANDARD_INSURANCE_GLI_PERCENTAGE = 0.035
  CREDIT_STANDARD_LOAN_INTEREST_PERCENTAGE_PER_YEAR = 0.01
  CREDIT_STANDARD_LOAN_INSURANCE_PERCENTAGE_PER_YEAR = 0.003

  FISCAL_STATUS_AVAILABLE = %w[Vide LMNP LMP Pinel DeNormandie].freeze
  FISCAL_REGIMEN_AVAILABLE = %w[Réel Forfait].freeze

  def initialize(args)
    super

    # House related
    self.house_notarial_fees_percentage = HOUSE_STANDARD_NOTARIAL_FEES_PERCENTAGE unless house_notarial_fees_percentage
    unless house_tenant_charges_percentage
      self.house_tenant_charges_percentage = HOUSE_STANDARD_TENANT_CHARGES_PERCENTAGE
    end
    unless house_insurance_pno_amount_per_year
      self.house_insurance_pno_amount_per_year = HOUSE_STANDARD_INSURANCE_PNO_AMOUNT_PER_YEAR
    end
    self.house_insurance_gli_percentage = HOUSE_STANDARD_INSURANCE_GLI_PERCENTAGE unless house_insurance_gli_percentage

    # Credit related
    unless credit_loan_interest_percentage_per_year
      self.credit_loan_interest_percentage_per_year = CREDIT_STANDARD_LOAN_INTEREST_PERCENTAGE_PER_YEAR
    end
    unless credit_loan_insurance_percentage_per_year
      self.credit_loan_insurance_percentage_per_year = CREDIT_STANDARD_LOAN_INSURANCE_PERCENTAGE_PER_YEAR
    end
  end

  #-----------------------------------------------------------------------#
  # House related formulas

  ## Notarial fees
  # Remember to put conditional if tenant charges amount is specified
  def house_notarial_fees_amount
    house_price_bought_amount * house_notarial_fees_percentage
  end

  ## Charges
  def house_tenant_charges_amount_per_year
    house_total_charges_amount_per_year * house_tenant_charges_percentage
  end

  def house_landlord_charges_amount_per_year
    house_total_charges_amount_per_year - house_tenant_charges_amount_per_year
  end

  ## Rent
  def house_rent_amount_per_year
    house_rent_amount_per_month * 12
  end

  ## Property management
  def house_property_management_amount_per_year
    house_rent_amount_per_year * house_property_management_cost_percentage
  end

  ## GLI
  def house_insurance_gli_amount_per_month
    house_insurance_gli_percentage * house_rent_amount_per_month
  end

  def house_insurance_gli_amount_per_year
    house_insurance_gli_percentage * house_rent_amount_per_year
  end

  #-----------------------------------------------------------------------#
  # Credit related formulas

  ## General
  def credit_loan_duration_in_months
    credit_loan_duration * 12
  end

  def credit_loan_payment_amount_per_month
    - pmt(credit_loan_interest_rate_per_month, credit_loan_duration_in_months, credit_loan_amount)
  end

  ## Interests
  def credit_loan_interest_rate_per_month
    credit_loan_interest_percentage_per_year / 12
  end

  def credit_loan_interest_cost_for_month(payment_period)
    - ipmt(credit_loan_interest_rate_per_month, payment_period, credit_loan_duration_in_months, credit_loan_amount)
  end

  def credit_loan_cumulative_interests_paid_for_year(payment_period)
    # Years are not 0 based
    start_per = ((payment_period - 1) * 12) + 1
    end_per = payment_period * 12
    - cumipmt(credit_loan_interest_rate_per_month, credit_loan_duration_in_months, credit_loan_amount, start_per,
              end_per)
  end

  def credit_loan_cumulative_interests_paid_for_year_two
    credit_loan_cumulative_interests_paid_for_year(2)
  end

  def credit_loan_cumulative_interests_paid_since_beginning_for_month(payment_period)
    - cumipmt(credit_loan_interest_rate_per_month, credit_loan_duration_in_months, credit_loan_amount, 1,
              payment_period)
  end

  def credit_loan_interest_total_amount
    credit_loan_cumulative_interests_paid_since_beginning_for_month(credit_loan_duration_in_months)
  end

  ## Principal
  def credit_loan_principal_repayment_for_month(payment_period)
    - ppmt(credit_loan_interest_rate_per_month, payment_period, credit_loan_duration_in_months, credit_loan_amount)
  end

  def credit_loan_cumulative_principal_paid_since_beginning_for_month(payment_period)
    - cumprinc(credit_loan_interest_rate_per_month, credit_loan_duration_in_months, credit_loan_amount, 1,
               payment_period)
  end

  def credit_loan_remaining_principal_to_pay_for_month(payment_period)
    credit_loan_amount - credit_loan_cumulative_principal_paid_since_beginning_for_month(payment_period)
  end

  ## Insurance
  def credit_loan_insurance_percentage_per_month
    credit_loan_insurance_percentage_per_year / 12
  end

  def credit_loan_insurance_amount_per_month
    credit_loan_amount * credit_loan_insurance_percentage_per_month
  end

  def credit_loan_insurance_amount_per_year
    credit_loan_amount * credit_loan_insurance_percentage_per_year
  end

  def credit_loan_insurance_total_amount
    credit_loan_insurance_amount_per_month * credit_loan_duration_in_months
  end

  #-----------------------------------------------------------------------#
  # Fiscal related formulas

  def fiscal_marital_status
    if fiscal_revenues_p2.nil?
      'Célibataire'
    else
      'Marié / Pacsé'
    end
  end

  def fiscal_income_tax_base_amount_per_year
    calc_income_tax_base_amount_per_year({
                                           fiscal_status: fiscal_status,
                                           fiscal_regimen: fiscal_regimen,
                                           fiscal_revenues_p1: fiscal_revenues_p1,
                                           fiscal_revenues_p2: fiscal_revenues_p2,
                                           fiscal_nb_parts: fiscal_nb_parts
                                         })
  end

  def fiscal_income_tax_incurred_by_taxable_property_income_amount_per_year
    calc_income_tax_incurred_by_taxable_property_income_amount_per_year({
                                                                          fiscal_status: fiscal_status,
                                                                          fiscal_regimen: fiscal_regimen,
                                                                          fiscal_revenues_p1: fiscal_revenues_p1,
                                                                          fiscal_revenues_p2: fiscal_revenues_p2,
                                                                          fiscal_nb_parts: fiscal_nb_parts,
                                                                          house_rent_amount_per_year: house_rent_amount_per_year,
                                                                          house_first_works_amount: house_first_works_amount,
                                                                          credit_loan_cumulative_interests_paid_for_year_two: credit_loan_cumulative_interests_paid_for_year_two
                                                                        })
  end

  def fiscal_income_tax_total_amount_per_year
    calc_income_tax_total_amount_per_year({
                                            fiscal_status: fiscal_status,
                                            fiscal_regimen: fiscal_regimen,
                                            fiscal_revenues_p1: fiscal_revenues_p1,
                                            fiscal_revenues_p2: fiscal_revenues_p2,
                                            fiscal_nb_parts: fiscal_nb_parts,
                                            house_rent_amount_per_year: house_rent_amount_per_year,
                                            house_first_works_amount: house_first_works_amount
                                          })
  end

  #-----------------------------------------------------------------------#
  # Profitability formulas

  def global_buying_operation_cost
    house_price_bought_amount * (1 + house_notarial_fees_percentage) + house_first_works_amount
  end

  def gross_profitability
    quotient = house_rent_amount_per_year
    divisor = global_buying_operation_cost

    quotient / divisor * 100
  end

  def net_profitability
    revenues = house_rent_amount_per_year
    expenses = house_tenant_charges_amount_per_year + house_property_tax_amount_per_year + house_insurance_pno_amount_per_year + house_insurance_gli_amount_per_year + house_property_management_amount_per_year
    divisor = global_buying_operation_cost + credit_loan_interest_total_amount + credit_loan_insurance_total_amount

    (revenues - expenses) / divisor * 100
  end

  def net_after_taxes_profitability
    6.6
  end

  #-----------------------------------------------------------------------#
  # Others (might be worth thinking move them away from model)

  def created_for
    returned_string = TimeDifference.between(created_at, DateTime.now).humanize
    find_words_only = /\b[^\d\W]+\b/
    returned_string_in_french = returned_string.gsub(find_words_only, time_in_french)
  end

  # Translations

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
