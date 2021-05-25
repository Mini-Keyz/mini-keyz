module SimulationsHelper
  FORMULA_ELEMENT_TO_CORRESPONDING_SIMULATION_VARIABLE = {
    "test": 'hey oh',
    "Loyer annuel HC": 'house_rent_amount_per_year',
    "Charges non récupérables": 'house_landlord_charges_amount_per_year',
    "Taxe foncière": 'house_property_tax_amount_per_year',
    "Assurance PNO": 'house_insurance_pno_amount_per_year',
    "Assurance GLI": 'house_insurance_gli_amount_per_year',
    "Frais de gestion(opt)": 'house_property_management_amount_per_year',
    "Prix d'achat": 'house_price_bought_amount',
    "Frais de notaire": 'house_notarial_fees_amount',
    "Eventuels travaux": 'house_first_works_amount',
    "Intérêts du crédit": 'credit_loan_interest_total_amount',
    "Assurance du crédit": 'credit_loan_insurance_total_amount'
  }.freeze

  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, class: 'error_explanation' do
        model.errors[attribute].join(', ')
      end
    end
  end

  def convert_formula_element_to_corresponding_simulation_variable(formula_element)
    FORMULA_ELEMENT_TO_CORRESPONDING_SIMULATION_VARIABLE[formula_element.to_sym]
  end
end
