# frozen_string_literal: true

module IncomeTaxesFormulas
  include(IncomeTaxesBaseFormulas)
  include(NueFormulas)
  include(LMNPFormulas)

  def calc_income_tax_incurred_by_property_income_amount_per_year(args = {})
    income_tax_base_amount_per_year = calc_income_tax_amount_per_year(args)

    income_tax_with_property_income_amount_per_year = case args[:fiscal_status]
                                                      when 'Vide'
                                                        NueFormulas.calc_income_tax_income_amount_per_year(args)
                                                      when 'LMNP'
                                                        LMNPFormulas.calc_income_tax_income_amount_per_year(args)
                                                      end

    income_tax_with_property_income_amount_per_year - income_tax_base_amount_per_year
  end
end
