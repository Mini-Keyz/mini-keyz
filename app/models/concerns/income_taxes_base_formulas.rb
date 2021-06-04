# frozen_string_literal: true

module IncomeTaxesBaseFormulas
  INCOME_TAXES_SCALE = {
    year2021: [
      { family_quotient_amount: { start_scale: 0, end_scale: 10_084 }, tax: 0 },
      { family_quotient_amount: { start_scale: 10_085, end_scale: 25_710 }, tax: 0.11 },
      { family_quotient_amount: { start_scale: 25_711, end_scale: 73_516 }, tax: 0.3 },
      { family_quotient_amount: { start_scale: 73_517, end_scale: 158_122 }, tax: 0.41 },
      { family_quotient_amount: { start_scale: 158_123, end_scale: BigDecimal('Infinity') }, tax: 0.45 }
    ]
  }.freeze

  FISCAL_NB_PARTS_FOR_MARRIED_COUPLE = 2
  FISCAL_NB_PARTS_FOR_SINGLE_PERSON = 1

  FAMILY_QUOTIENT_CAPPING_AMOUNT = {
    # Per half fiscal parts for children
    year2021: 1570
  }.freeze

  REVENUES_STANDARD_ALLOWANCE = 0.1

  REAL_REGIMEN_DEDUCTIBLE_EXPENSES_FOR_YEAR_TWO = %i[house_landlord_charges_amount_per_year
                                                     house_property_management_amount_per_year house_insurance_gli_amount_per_year house_insurance_pno_amount_per_year house_property_tax_amount_per_year credit_loan_cumulative_interests_paid_for_year_two credit_loan_insurance_amount_per_year].freeze

  # Main formula
  def self.calc_income_tax_amount_per_year(args = {}, net_taxable_property_income_amount = 0)
    global_net_taxable_income_amount = calc_global_net_taxable_amount(args, net_taxable_property_income_amount)

    fiscal_nb_parts = calc_fiscal_nb_parts

    family_quotient_amount = calc_family_quotient_amount(global_net_taxable_income_amount, fiscal_nb_parts)
    current_year = Date.today.year

    aggregated_tax_amount = calc_aggregated_tax_amount(family_quotient_amount, current_year)

    (aggregated_tax_amount * fiscal_nb_parts).floor
  end

  def self.calc_income_taxes_scale(args = {}, net_taxable_property_income_amount = 0)
    global_net_taxable_income_amount = calc_global_net_taxable_amount(args, net_taxable_property_income_amount)

    fiscal_nb_parts = calc_fiscal_nb_parts

    family_quotient_amount = calc_family_quotient_amount(global_net_taxable_income_amount,
                                                         calc_fiscal_nb_parts)
    current_year = Date.today.year

    income_taxes_scale = INCOME_TAXES_SCALE["year#{current_year}".to_sym]

    income_taxes_scale.find { |scale| family_quotient_amount <= scale[:family_quotient_amount][:end_scale] }
  end

  def self.calc_global_net_taxable_amount(args = {}, net_taxable_property_income_amount = 0)
    ((args[:fiscal_revenues_p1] + args[:fiscal_revenues_p2]) * (1 - REVENUES_STANDARD_ALLOWANCE)) + net_taxable_property_income_amount
  end

  def calc_fiscal_nb_parts
    case fiscal_marital_status
    when 'Marié / Pacsé'
      FISCAL_NB_PARTS_FOR_MARRIED_COUPLE + calc_fiscal_nb_parts_for_dependent_children + calc_fiscal_nb_parts_for_alternate_custody_children
    when 'Célibataire'
      FISCAL_NB_PARTS_FOR_SINGLE_PERSON + calc_fiscal_nb_parts_for_dependent_children + calc_fiscal_nb_parts_for_alternate_custody_children
    end
  end

  def calc_fiscal_nb_parts_for_dependent_children
    if fiscal_nb_dependent_children <= 2
      fiscal_nb_dependent_children * 0.5
    elsif fiscal_nb_dependent_children >= 3
      1 + (fiscal_nb_dependent_children - 2)
    end
  end

  def calc_fiscal_nb_parts_for_alternate_custody_children
    if fiscal_nb_alternate_custody_children <= 2
      fiscal_nb_alternate_custody_children * 0.25
    elsif fiscal_nb_alternate_custody_children >= 3
      0.5 + (fiscal_nb_alternate_custody_children - 2) * 0.5
    end
  end

  def self.calc_family_quotient_amount(global_net_taxable_income_amount, fiscal_nb_parts)
    global_net_taxable_income_amount / fiscal_nb_parts
  end

  def self.calc_family_quotient_capped_amount(_e)
    'ee'
  end

  def self.calc_aggregated_tax_amount(family_quotient_amount, current_year)
    income_taxes_scale = INCOME_TAXES_SCALE["year#{current_year}".to_sym]

    income_taxes_scale.map do |scale|
      if family_quotient_amount < scale[:family_quotient_amount][:start_scale]
        0
      elsif family_quotient_amount >= scale[:family_quotient_amount][:start_scale] && family_quotient_amount < scale[:family_quotient_amount][:end_scale]
        (family_quotient_amount - scale[:family_quotient_amount][:start_scale]) * scale[:tax]
      elsif family_quotient_amount >= scale[:family_quotient_amount][:end_scale]
        (scale[:family_quotient_amount][:end_scale] - scale[:family_quotient_amount][:start_scale]) * scale[:tax]
      end
    end.sum
  end
end
