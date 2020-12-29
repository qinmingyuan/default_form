# frozen_string_literal: true

module DefaultForm::Builder::Wrap

  def wrapping(type, inner, tag: 'div', wrap: {})
    if wrap[type].present?
      css_ary = wrap[type].split(' > ')
      css_ary.reverse_each.with_index do |css, index|
        if index == 0
          inner = content_tag(tag, inner, class: css)
        else
          inner = content_tag('div', inner, class: css)
        end
      end
    end

    inner
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
        inner += help_tag(help_text) if help_text
      end
      content_tag(:div, inner, class: final_css)
    else
      inner
    end
  end

  def offset(text = '', origin: {})
    if origin[:offset].present?
      content_tag(:div, text, class: origin[:offset])
    else
      ''.html_safe
    end
  end

  def help_tag(text)
    DefaultForm.config.help_tag.call(self, text)
  end

  def object_has_errors?(method)
    object.respond_to?(:errors) && object.errors.respond_to?(:[]) && object.errors[method].present?
  end

end
