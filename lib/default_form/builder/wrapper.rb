module DefaultForm::Builder::Wrapper

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

  def wrapper_input(inner, config:)
    on = origin_on.merge(config[:on] || {})
    css = origin_css.merge(config[:css] || {})

    if on[:wrapper_input]
      content_tag(:div, inner, class: css[:wrapper_input])
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

  def offset(text = '')
    if origin_on[:offset]
      content_tag(:label, text, class: origin_css[:offset])
    else
      ''
    end
  end

  def object_has_errors?(method)
    object.respond_to?(:errors) && object.errors.respond_to?(:[]) && object.errors[method].present?
  end

end

