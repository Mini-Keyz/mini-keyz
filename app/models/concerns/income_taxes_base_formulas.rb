# frozen_string_literal: true

module IncomeTaxesBaseFormulas
  INCOME_TAXES_SCALE = {
    its2021: [
      { taxable_amount: { start_scale: 0, end_scale: 10_084 }, tax: 0 },
      { taxable_amount: { start_scale: 10_085, end_scale: 25_710 }, tax: 0.11 },
      { taxable_amount: { start_scale: 25_711, end_scale: 73_516 }, tax: 0.3 },
      { taxable_amount: { start_scale: 73_517, end_scale: 158_122 }, tax: 0.41 },
      { taxable_amount: { start_scale: 158_123, end_scale: BigDecimal('Infinity') }, tax: 0.45 }
    ]
  }
  LUMP_SUMP_ALLOWANCE = 0.1

  def calc_income_tax_without_property_income_amount_per_year(args = {})
    taxable_amount = calc_taxable_amount(args[:fiscal_revenues_p1], args[:fiscal_revenues_p2], args[:fiscal_nb_parts])
    current_year = Date.today.year

    aggregated_tax_amount = calc_aggregated_tax_amount(taxable_amount, current_year)

    (aggregated_tax_amount * args[:fiscal_nb_parts]).floor
  end

  def calc_taxable_amount(fiscal_revenues_p1, fiscal_revenues_p2, fiscal_nb_parts)
    ((fiscal_revenues_p1 + fiscal_revenues_p2) * (1 - LUMP_SUMP_ALLOWANCE)) / fiscal_nb_parts
  end

  def calc_aggregated_tax_amount(taxable_amount, year)
    income_taxes_scale = INCOME_TAXES_SCALE["its#{year}".to_sym]

    income_taxes_scale.map do |scale|
      if taxable_amount < scale[:taxable_amount][:start_scale]
        0
      elsif taxable_amount >= scale[:taxable_amount][:start_scale] && taxable_amount < scale[:taxable_amount][:end_scale]
        (taxable_amount - scale[:taxable_amount][:start_scale]) * scale[:tax]
      elsif taxable_amount >= scale[:taxable_amount][:end_scale]
        (scale[:taxable_amount][:end_scale] - scale[:taxable_amount][:start_scale]) * scale[:tax]
      end
    end.sum
  end
end
