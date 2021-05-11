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
end
