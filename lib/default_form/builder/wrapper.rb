module DefaultForm::Builder::Wrapper

  def wrapper_input(inner, config:)
    on = origin_on.merge(config[:on] || {})
    css = origin_css.merge(config[:css] || {})

    if on[:wrapper_input]
      content_tag(:div, inner, class: css[:wrapper_input])
    else
      inner
    end
  end

  def wrapper_checkbox(inner, config:)
    on = origin_on.merge(config[:on] || {})
    css = origin_css.merge(config[:css] || {})

    if on[:wrapper_checkbox]
      content_tag(:div, inner, class: css[:wrapper_checkbox])
    else
      inner
    end
  end

  def wrapper_submit(inner, config:)
    on = origin_on.merge(config[:on] || {})
    css = origin_css.merge(config[:css] || {})

    if on[:wrapper_submit]
      content_tag(:div, inner, class: css[:wrapper_submit])
    else
      inner
    end
  end

  def wrapper_all(inner, method = nil, config:)
    on = origin_on.merge(config[:on] || {})
    css = origin_css.merge(config[:css] || {})

    if method && object_has_errors?(method)
      final_css = css[:wrapper_all_error]
    else
      final_css = css[:wrapper_all]
    end

    if on[:wrapper_all]
      content_tag(:div, inner, class: final_css)
    else
      inner
    end
  end

  def offset(text = '', config:)
    on = origin_on.merge(config[:on] || {})
    css = origin_css.merge(config[:css] || {})

    if on[:offset]
      content_tag(:div, text, class: css[:offset])
    else
      ''.html_safe
    end
  end

  def object_has_errors?(method)
    object.respond_to?(:errors) && object.errors.respond_to?(:[]) && object.errors[method].present?
  end

end
