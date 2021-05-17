class Simulation < ApplicationRecord
  belongs_to :user
  validates :house_city, presence: true
  validates :house_price_bought, presence: true, numericality: { only_integer: true }
  validates :house_first_works, numericality: { only_integer: true }
  validates :house_annual_charges, presence: true, numericality: { only_integer: true }
  validates :house_property_tax, presence: true, numericality: { only_integer: true }
  validates :house_rent_per_month, presence: true, numericality: { only_integer: true }
  validates :house_delegated_maintenance_value, presence: true
  validates :credit_amount, presence: true, numericality: { only_integer: true }
  validates :credit_duration, presence: true, numericality: { only_integer: true }
  validates :fiscal_status, presence: true
  validates :fiscal_regimen, presence: true
  validates :fiscal_revenues_p1, presence: true, numericality: { only_integer: true }
  validates :fiscal_revenues_p2, numericality: { only_integer: true }
  validates :fiscal_nb_parts, presence: true

  include(CreditFormulas)

  def initialize(args)
    super
    self.house_notarial_fees = 0.08 unless house_notarial_fees
    self.credit_interest_rate = 0.01 unless credit_interest_rate
    self.credit_insurance_rate = 0.003 unless credit_insurance_rate
  end

  def gross_profitability
    house_rent_per_year = house_rent_per_month * 12
    global_buying_operation_cost = house_price_bought * (1 + house_notarial_fees) + house_first_works

    house_rent_per_year / global_buying_operation_cost * 100
  end

  def created_for
    returned_string = TimeDifference.between(created_at, Date.today).humanize
    find_words_only = /\b[^\d\W]+\b/
    returned_string_in_french = returned_string.gsub(find_words_only, time_in_french)
  end

  # Credit cost
  def credit_duration_in_months
    credit_duration * 12
  end

  def credit_interest_rate_per_month
    credit_interest_rate / 12
  end

  def credit_mensuality
    - pmt(credit_interest_rate_per_month, credit_duration_in_months, credit_amount)
  end

  def credit_interest_cost_for_month(payment_period)
    - ipmt(credit_interest_rate_per_month, payment_period, credit_duration_in_months, credit_amount)
  end

  def credit_principal_repayment_for_month(payment_period)
    - ppmt(credit_interest_rate_per_month, payment_period, credit_duration_in_months, credit_amount)
  end

  def credit_cumulative_principal_paid_for_month(payment_period)
    - cumprinc(credit_interest_rate_per_month, credit_duration_in_months, credit_amount, 1, payment_period)
  end

  def credit_remaining_principal_to_pay_for_month(payment_period)
    credit_amount - credit_cumulative_principal_paid_for_month(payment_period)
  end

  # Credit insurance

  def credit_insurance_rate_per_month
    credit_insurance_rate / 12
  end

  def credit_insurance_cost_per_month
    credit_insurance_rate_per_month * credit_amount
  end

  def credit_insurance_total_cost
    credit_insurance_cost_per_month * credit_duration_in_months
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
