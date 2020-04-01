# frozen_string_literal: true

module DefaultForm::Builder::Wrap

  def wrap_input(inner, method, can: {}, css: {})
    if can[:wrap_input]
      if can[:wrap_input_id]
        content_tag(:div, inner, class: css[:wrap_input], id: wrap_input_id(method))
      else
        content_tag(:div, inner, class: css[:wrap_input])
      end
    else
      inner
    end
  end

  def wrap(type, inner, can: {}, css: {})
    if can[:"wrap_#{type}"]
      content_tag(:div, inner, class: css[:"wrap_#{type}"])
    else
      inner
    end
  end

  def wrap_checkbox(inner, options: {})
    if options.dig(:can, :wrap_checkbox)
      content_tag(:label, inner, class: options.dig(:css, :wrap_checkbox))
    else
      inner
    end
  end

  def wrap_all(inner, method = nil, can: {}, css: {}, required: false)
    if method && object_has_errors?(method)
      final_css = css[:wrap_all_error]
    elsif required
      final_css = css[:wrap_all_required]
    else
      final_css = css[:wrap_all]
    end

    if can[:wrap_all]
      if method
        help_text = default_help(method)
        inner += help_tag(help_text, css[:help_icon]) if help_text
      end

      if method && can[:wrap_all_id]
        content_tag(:div, inner, class: final_css, id: wrap_all_id(method))
      else
        content_tag(:div, inner, class: final_css)
      end
    else
      inner
    end
  end

  def offset(text = '', can: {}, css: {})
    if can[:offset]
      content_tag(:div, text, class: css[:offset])
    else
      ''.html_safe
    end
  end

  def help_tag(text, css)
    content_tag(:span, data: { tooltip: text }) do
      content_tag(:i, nil, class: css)
    end
  end

  def object_has_errors?(method)
    object.respond_to?(:errors) && object.errors.respond_to?(:[]) && object.errors[method].present?
  end

  def wrap_all_id(method)
    "#{wrap_id(method)}_wrap"
  end

  def wrap_input_id(method)
    "#{wrap_id(method)}_input"
  end

  def wrap_id(method)
    [@object_name, method].map! do |i|
      i.to_s.gsub(/\]\[|[^-a-zA-Z0-9:.]/, '_').sub(/^_|_$/, '')
    end.join('_')
  end

end
