module SimulationsHelper
  FORMULA_ELEMENT_TO_CORRESPONDING_SIMULATION_VARIABLE = {
    "test": 'hey oh',
    "Loyer annuel HC": 'house_rent_amount_per_year',
    "Prix d'achat": 'house_price_bought_amount',
    "Frais de notaire": 'xxx'
  }.freeze

  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, class: 'error_explanation' do
        model.errors[attribute].join(', ')
      end
    end
  end

  def tooltip_formula(formula_elements_array)
    formula_elements_array.map!.with_index do |formula_element, i|
      i.even? ? tooltip(formula_element) : formula_element
    end.join(' ')
  end

  def tooltip(formula_element)
    tooltip = 'relative inline-block border-b border-dotted border-gray-400 group'
    tooltiptext = 'absolute z-10 bottom-full left-1/2 transform -translate-x-1/2 bg-gray-600 text-white text-center px-5 rounded-md invisible group-hover:visible'

    "<span class='#{tooltip}'>
      #{formula_element}
      <span class='#{tooltiptext}'>
        <%= simulation.#{convert_formula_element_to_corresponding_simulation_variable(formula_element)} %>
      </span>
    </span>"
  end

  def convert_formula_element_to_corresponding_simulation_variable(formula_element)
    FORMULA_ELEMENT_TO_CORRESPONDING_SIMULATION_VARIABLE[formula_element.to_sym]
  end
end
