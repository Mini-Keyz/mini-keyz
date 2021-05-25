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
    "#{element} <b>tooltiped</b>"
  end
end
