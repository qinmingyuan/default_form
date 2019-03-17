module DefaultForm::Builder::Wrapper

  def wrapper_input(inner, config:)
    on = origin_on.merge(config[:on])
    css = origin_css.merge(config[:css])

    if on[:wrapper_input]
      content_tag(:div, inner, class: css[:wrapper_input])
    else
      inner
    end
  end

  def wrapper_select(inner, config:)
    on = origin_on.merge(config[:on])
    css = origin_css.merge(config[:css])

    if on[:wrapper_select]
      content_tag(:div, inner, class: css[:wrapper_select])
    else
      inner
    end
  end

  def wrapper_checkbox(inner, config:)
    on = origin_on.merge(config[:on])
    css = origin_css.merge(config[:css])

    if on[:wrapper_checkbox]
      content_tag(:div, inner, class: css[:wrapper_checkbox])
    else
      inner
    end
  end

  def wrapper_checkboxes(inner, config:)
    on = origin_on.merge(config[:on] || {})
    css = origin_css.merge(config[:css] || {})

    if on[:wrapper_checkboxes]
      content_tag(:div, inner, class: css[:wrapper_checkboxes])
    else
      inner
    end
  end

  def wrapper_radio(inner, config:)
    on = origin_on.merge(config[:on])
    css = origin_css.merge(config[:css])

    if on[:wrapper_radio]
      content_tag(:div, inner, class: css[:wrapper_radio])
    else
      inner
    end
  end

  def wrapper_radios(inner, config:)
    on = origin_on.merge(config[:on] || {})
    css = origin_css.merge(config[:css] || {})

    if on[:wrapper_radios]
      content_tag(:div, inner, class: css[:wrapper_radios])
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
    elsif config[:required]
      final_css = css[:wrapper_all_required]
    else
      final_css = css[:wrapper_all]
    end

    if on[:wrapper_all]
      if method && on[:wrapper_id]
        content_tag(:div, inner, class: final_css, id: wrapper_id(method))
      else
        content_tag(:div, inner, class: final_css)
      end
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

  def wrapper_id(method)
    object_name = object.class.base_class.model_name.param_key
    sanitized_object_name = object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/, '_').sub(/_$/, '')
    sanitized_method_name = method.to_s.sub(/\?$/, '')
    "#{sanitized_object_name}_#{sanitized_method_name}_wrapper"
  end

end
