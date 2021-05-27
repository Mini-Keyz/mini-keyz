# frozen_string_literal: true

module NueFormulas
  include(IncomeTaxesBaseFormulas)

  DEDUCTIBLE_EXPENSES = %i[house_first_works_amount].freeze
  PROPERTY_INCOME_DEDUCTION_PERCENTAGE = 0.3

  def calc_property_income(args = {})
    case args[:fiscal_regimen]
    when 'Réel'
      deductible_expenses = DEDUCTIBLE_EXPENSES.map { |expense| args[expense] }.sum
      args[:house_rent_amount_per_year] - deductible_expenses
    when 'Forfait'
      args[:house_rent_amount_per_year] * (1 - PROPERTY_INCOME_DEDUCTION_PERCENTAGE)
    end
  end

  def calc_income_tax_income_amount_per_year(args = {})
    property_income = calc_property_income(args)
    IncomeTaxesBaseFormulas.calc_income_tax_amount_per_year(args, property_income)
  end
end
