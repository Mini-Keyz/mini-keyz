# frozen_string_literal: true

module NueFormulas
  include(IncomeTaxesBaseFormulas)

  PROPERTY_INCOME_STANDARD_ALLOWANCE = 0.3

  def self.calc_income_tax_amount_for_year_two(args = {})
    net_taxable_property_income_amount = calc_net_taxable_property_income_amount_for_year_two(args)
    IncomeTaxesBaseFormulas.calc_income_tax_amount_per_year(args, net_taxable_property_income_amount)
  end

  def self.calc_net_taxable_property_income_amount_for_year_two(args = {})
    case args[:fiscal_regimen]
    when 'Réel'
      deductible_expenses = IncomeTaxesBaseFormulas::REAL_REGIMEN_DEDUCTIBLE_EXPENSES_FOR_YEAR_TWO.map do |expense|
        args[expense] || 0
      end.sum
      args[:house_rent_amount_per_year] - deductible_expenses
    when 'Forfait'
      args[:house_rent_amount_per_year] * (1 - PROPERTY_INCOME_STANDARD_ALLOWANCE)
    end
  end
end
