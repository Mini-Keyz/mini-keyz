# frozen_string_literal: true

module IncomeTaxesFormulas
  include(IncomeTaxesBaseFormulas)
  include(NueFormulas)
  include(LmnpFormulas)

  def calc_income_tax_total_amount_per_year(args = {})
    case args[:fiscal_status]
    when 'Vide'
      NueFormulas.calc_income_tax_amount_per_year(args)
    when 'LMNP'
      LmnpFormulas.calc_income_tax_amount_per_year(args)
    end
  end

  def calc_income_tax_base_amount_per_year(args = {})
    IncomeTaxesBaseFormulas.calc_income_tax_amount_per_year(args)
  end

  def calc_income_tax_incurred_by_property_income_amount_per_year(args = {})
    income_tax_base_amount_per_year = calc_income_tax_base_amount_per_year(args)
    income_tax_with_property_income_amount_per_year = calc_income_tax_total_amount_per_year(args)

    income_tax_with_property_income_amount_per_year - income_tax_base_amount_per_year
  end
end
