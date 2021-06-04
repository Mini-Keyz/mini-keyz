# frozen_string_literal: true

module IncomeTaxesFormulas
  include(IncomeTaxesBaseFormulas)
  include(NueFormulas)
  include(LmnpFormulas)

  def calc_income_tax_incurred_by_taxable_property_income_amount_for_year_two(args = {})
    income_tax_base_amount_per_year = calc_income_tax_base_amount_per_year(args)
    income_tax_with_taxable_property_income_amount_for_year_two = calc_income_tax_total_amount_for_year_two(args)

    income_tax_with_taxable_property_income_amount_for_year_two - income_tax_base_amount_per_year
  end

  def calc_income_tax_base_amount_per_year(args = {})
    IncomeTaxesBaseFormulas.calc_income_tax_amount_per_year(args)
  end

  def calc_income_tax_total_amount_for_year_two(args = {})
    case args[:fiscal_status]
    when 'Vide'
      NueFormulas.calc_income_tax_amount_for_year_two(args)
    when 'LMNP'
      LmnpFormulas.calc_income_tax_amount_for_year_two(args)
    end
  end

  def calc_fiscal_nb_parts(simulation_instance)
    IncomeTaxesBaseFormulas.calc_fiscal_nb_parts(simulation_instance)
  end
end
