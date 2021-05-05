class Simulation < ApplicationRecord
  belongs_to :user
  validates :house_city, presence: true
  validates :house_price_bought, presence: true, numericality: { only_integer: true }
  validates :house_first_works, numericality: { only_integer: true }
  validates :house_annual_charges, presence: true, numericality: { only_integer: true }
  validates :house_property_tax, presence: true, numericality: { only_integer: true }
  validates :house_rent_per_month, presence: true, numericality: { only_integer: true }
  validates :house_delegated_maintenance_value, presence: true
end
