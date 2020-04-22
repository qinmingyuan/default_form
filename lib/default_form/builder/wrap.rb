# frozen_string_literal: true

module DefaultForm::Builder::Wrap

  def wrapping(type, inner, tag: 'div', wrap: {})
    if wrap[type].present?
      css_ary = wrap[type].split(' > ')
      css_ary.reverse_each do |css|
        inner = content_tag(tag, inner, class: css)
      end
    end

    inner
  end

  def wrap_checkbox(inner, can: {}, css: {})
    if can[:wrap_checkbox]
      content_tag(:label, inner, class: css[:wrap_checkbox])
    else
      inner
    end
  end

  def wrapping_all(inner, method = nil, wrap: {}, required: false)
    if method && object_has_errors?(method)
      final_css = wrap[:all_error]
    elsif required
      final_css = wrap[:all_required]
    else
      final_css = wrap[:all]
    end

    if final_css
      if method
        help_text = default_help(method)
        inner += help_tag(help_text, css[:help_icon]) if help_text
      end
      content_tag(:div, inner, class: final_css)
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

end
