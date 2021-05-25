module SimulationsHelper
  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, class: 'error_explanation' do
        model.errors[attribute].join(', ')
      end
    end
  end

  def tooltip_formula(formula_array)
    formula_array.map!.with_index { |element, i| i.even? ? tooltip(element) : element }.join(' ')
  end

  def tooltip(element)
    tooltip = 'relative inline-block border-b border-dotted border-gray-400 group'
    tooltiptext = 'absolute z-10 bottom-full left-1/2 transform -translate-x-1/2 bg-gray-600 text-white text-center px-5 rounded-md invisible group-hover:visible'

    "<span class='#{tooltip}'>
      #{element}
      <span class='#{tooltiptext}'>
        Tooltip text
      </span>
    </span>"
  end
end
