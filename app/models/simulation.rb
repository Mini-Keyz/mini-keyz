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

  def initialize(args)
    super
    self.house_notarial_fees = 0.08 unless house_notarial_fees
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

  # Credit calculation methods

  def credit_reimbursement_per_year
    credit_amount / credit_duration
  end

  def credit_reimbursement_per_month
    credit_amount / (credit_duration * 12)
  end

  def remaining_credit_amount(credit_ongoing_year)
    credit_amount - (credit_ongoing_year * credit_reimbursement_per_year)
  end

  def credit_cost_for_year(credit_ongoing_year)
    credit_rate * remaining_credit_amount(credit_ongoing_year) + credit_insurance_rate * credit_amount
  end

  def total_credit_cost
    credit_costs_array = (1..credit_duration).each_with_object([]) do |credit_ongoing_year, array|
      array << credit_cost_for_year(credit_ongoing_year)
    end
    credit_costs_array.sum
  end
end
